class TimecardsController < ApplicationController
  before_action :get_user
  before_action :get_timecard, only: [:show, :edit, :update, :destroy]
  before_action :can_edit?, except: [:index, :show]

  def index
    @timecards = @user.timecards.all
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
    @timecard = @user.timecards.find(params[:id])
  end

  def timecard_params
    params.require(:timecard).permit(:start, :end, :description)
  end
  
end
