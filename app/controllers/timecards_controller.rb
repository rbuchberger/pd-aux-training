class TimecardsController < ApplicationController

  # This index action is for a user to view their own timecards
  def index
    authorize Timecard
    @user = current_user
    # Passing current_user to the presenter will only return that user's
    # records, even if some other user_id is specified in params. 
    @timecards = TimecardsPresenter::FilteredTimecards.new(timecards_filter_params, @user)
  end
  
  # This allows administrators to view and filter timecards
  def admindex
    # Not passing a user argument to the presenter returns all users. If params
    # includes a user_id, it will return timecards for that user. 
    authorize Timecard
    @timecards = TimecardsPresenter::FilteredTimecards.new(timecards_filter_params)
    @select_options = @timecards.select_options
  end
  
  def new
    @user = current_user
    @timecard ||= Timecard.new
    authorize @timecard
  end
  
  def create
    @user = current_user
    @timecard = @user.timecards.new(timecard_params)
    authorize @timecard
    if @timecard.save
      flash[:success] = "Timecard logged!"
      redirect_to timecards_path
    else
      flash.now[:danger] = "Could not log timecard!"
      render :new
    end
  end
  
  def show
    @timecard = get_timecard
    @user = @timecard.user
  end
  
  def edit
    @timecard ||= get_timecard
    @user = @timecard.user
  end
    
  def update
    @timecard = get_timecard
    @user = @timecard.user
    if @timecard.update(timecard_params)
      flash[:success] = "Timecard Updated!"
      redirect_to  timecard_path(@timecard)
    else
      flash.now[:danger] = "Could not update timecard!"
      render :edit
    end
  end
  
  def destroy
    @timecard = get_timecard
    if @timecard.destroy
      flash[:success] = "Timecard deleted!"
      redirect_to timecards_path
    else
      flash.now[:danger] = "Could not delete timecard."
      render :show 
    end
  end
  
  private
  
  def get_timecard
    timecard = Timecard.includes(:user).find(params[:id])
    authorize timecard
    timecard
  end

  def timecard_params
    params.require(:timecard).permit(:clock_in_time, :clock_in_date, :clock_out_time, :description)
  end

  def timecards_filter_params
   params.permit(:user_id, :range_start, :range_end)
  end


end
