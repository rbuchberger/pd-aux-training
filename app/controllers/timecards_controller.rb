class TimecardsController < ApplicationController

  before_action :can_edit?,   except: [:index, :show, :destroy, :admindex]
  before_action :can_see?,      only: [:index, :show, :admindex]
  before_action :can_destroy?,  only: [:delete]

  # This index action is only used for viewing a single users' timecards. 
  # There will be another created for admins & trainers who wish to view all 
  # timecards in a big list. 

  def index
    @user = get_user
    @timecards = TimecardsPresenter::FilteredTimecards.new(timecards_filter_params)
  end
  
  # Admins need their own action. Tried to combine it with the regular index
  # view, but "view all users' timecards" needed too many hacks. 
  def admindex
    @timecards = TimecardsPresenter::FilteredTimecards.new(timecards_filter_params)
    @select_options = TimecardsPresenter::SelectOptions.new
  end
  
  def new
    @user = get_user
    @timecard = Timecard.new
  end
  
  def create
    @user = get_user
    @timecard = @user.timecards.new(timecard_params)
    if @timecard.save
      flash[:success] = "Timecard logged!"
      redirect_to timecards_path
    else
      flash[:danger] = "Could not log timecard!"
      render new_timecard_path
    end
  end
  
  def show
    @timecard = get_timecard
    @user = @timecard.user
  end
  
  def edit
    @timecard = get_timecard
    @user = @timecard.user
  end
    
  def update
    @timecard = get_timecard
    @user = @timecard.user
    if @timecard.update(timecard_params)
      flash[:success] = "Timecard Updated!"
      redirect_to timecards_path
    else
      flash[:danger] = "Could not update timecard!"
      render edit_timecard_path(@timecard)
    end
  end
  
  def destroy
    @timecard = get_timecard
    if @timecard.destroy
      flash[:success] = "Timecard deleted!"
      redirect_to timecards_path
    else
      flash[:danger] = "Could not delete timecard."
      redirect_to timecard_path(@timecard)
    end
  end
  
  private
  
  def get_user
    if params[:user_id].to_i > 0
      User.find(params[:user_id])
    else
      current_user
    end
  end
  
  def get_timecard
    Timecard.find(params[:id])
  end

  def timecard_params
    params.require(:timecard).permit(:start, :end, :description)
  end

  def timecards_filter_params
   params.permit(:user_id, :start, :finish)
  end
  
  def can_see?
    redirect_to root_path unless @user == current_user || current_user.trainer? 
  end
  
  def can_edit?
    redirect_to root_path unless @user == current_user
  end
  
  def can_destroy?
    redirect_to root_path unless @user == current_user || current_user.admin?
  end

end
