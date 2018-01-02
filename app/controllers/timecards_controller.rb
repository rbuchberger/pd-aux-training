class TimecardsController < ApplicationController

  # This index action is only used for viewing a single users' timecards. 
  def index
    @user = current_user
    # Passing current_user to the presenter will only return that user's
    # records, even if some other user_id is specified in params. 
    @timecards = TimecardsPresenter::FilteredTimecards.new(timecards_filter_params, @user)
  end
  
  # Admins need their own action. Tried to combine it with the regular index
  # view, but "view all users' timecards" needed too many hacks. 
  # Maybe one day when I'm smarter I'll combine the two for more RESTfulness.
  def admindex
    # Not passing a user argument to the presenter returns all users. If params
    # includes a user_id, it will return timecards for that user. 
    @timecards = TimecardsPresenter::FilteredTimecards.new(timecards_filter_params)
    @select_options = TimecardsPresenter::SelectOptions.new
  end
  
  def new
    @user = current_user
    @timecard = Timecard.new
  end
  
  def create
    @user = current_user
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
  
  def get_timecard
    Timecard.find(params[:id])
  end

  def timecard_params
    params.require(:timecard).permit(:start, :end, :description)
  end

  def timecards_filter_params
   params.permit(:user_id, :range_start, :range_end)
  end


end
