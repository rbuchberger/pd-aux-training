# The logic for retrieving and filtering timecards has been placed in its own
# PORO class, located in app/presenters/timecards_presenter.rb
# I'm not sure if it's unnecessarily convoluted or good OO design. We'll see
# how big that class gets and maybe I'll put it back in the controller. 

class TimecardsController < ApplicationController

  before_action :get_user
  before_action :can_edit?,   except: [:index, :show]
  before_action :can_see?,      only: [:index, :show]
  before_action :get_timecard,  only: [:show, :edit, :update, :destroy]

  # This index action is only used for viewing a single users' timecards. 
  # There will be another created for admins & trainers who wish to view all 
  # timecards in a big list. 

  def index
    puts get_timecards_params
    puts @date_range = {start: 30.days.ago, finish: Time.zone.today}.merge(get_timecards_params)
    @timecards = TimecardsPresenter::FilteredTimecards.new(@date_range, @user)
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
    if params[:user_id].to_i > 0
      @user = User.find(params[:user_id])
    elsif params[:user_id].to_i != -1 # -1 allows admins to see all timecards
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
    # Converted to a hash, and nil values removed. 
  params.permit(:user_id, :start, :finish).to_h.compact.symbolize_keys
  end

end
