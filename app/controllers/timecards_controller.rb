# The logic for retrieving and filtering timecards has been placed in its own
# PORO class, located in app/presenters/timecards_presenter.rb
# I'm not sure if it's unnecessarily convoluted or good OO design. We'll see
# how big that class gets and maybe I'll put it back in the controller. 

class TimecardsController < ApplicationController

  before_action :get_user
  before_action :can_edit?,   except: [:index, :show]
  before_action :can_see?,      only: [:index, :show]
  before_action :get_timecard,  only: [:show, :edit, :update, :destroy]

  # The index method is used in 3 cases: any user viewing their own timecard, 
  # an admin/trainer viewing a single user's timecards, or an admin/trainer 
  # viewing all users' timecards. The permissions are controlled in the before_actions.

  def index
    @timecards = TimecardsPresenter::FilteredTimecards.new(get_timecards_params)
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
    if params[:user_id] > 0
      @user = User.find(params[:user_id])
    elsif params[:user_id] != -1 # -1 allows admins to see all timecards
      @user = current_user
    end
  end
  
  def can_see?
    redirect_to root_path unless (current_user.admin? || current_user.trainer? || @user == current_user)
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
    params.permit(:user_id, :start, :finish)
  end

end
