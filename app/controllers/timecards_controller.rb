class TimecardsController < ApplicationController
  # Get user also checks for admin/trainer "can see" priveliges. Is that the proper
  # way? Shouldn't methods only do one thing, or can I use them to do several?
  # I like it because it reduces redundant before_actions applied to the same 
  # methods. 
  before_action :get_user
  before_action :can_edit?, except: [:index, :show]
  before_action :get_timecard, only: [:show, :edit, :update, :destroy]

  def index
    # The logic for retrieving and filtering timecards has been placed in its own
    # PORO class, located in app/presenters/timecards_presenter.rb
    # I'm not sure if it's unnecessarily convoluted or good OO design. We'll see
    # how big that class gets and maybe I'll put it back in the controller. 
    @timecards = TimecardsPresenter::FilteredTimecards.new(@user, params(:start), params(:finish))
  end
  
  def new
    @timecard = Timecard.new
  end
  
  def create
    @timecard = @user.timecards.create(timecard_params)
    redirect_to timecards_path
  end
  
  def show
    
  end
  
  def edit
    
  end
  
  def update
    @timecard.update!(timecard_params)
  end
  
  def destroy
    @timecard.destroy!
    redirect_to timecards_path
  end
  
  private
  
  def get_user
    # If a user is specified in parameters, check to see if  the current user is 
    # an admin or a trainer. If not specified, set @user to current_user. 
    if params[:user_id]
      redirect_to root_path unless (current_user.admin? || current_user.trainer?)
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end
  end
  
  def can_edit?
    redirect_to root_path unless @user == current_user
  end

  def get_timecard
    @timecard = Timecard.find(params[:id])
  end

  def timecard_params
    # Parameters for creating or editing a new timecard
    params.require(:timecard).permit(:start, :end, :description)
  end
  
  def get_timecards_params
    # Parameters for filtering list of timecards
    params.permit(:user, :start, :finish)
  end
  
end
