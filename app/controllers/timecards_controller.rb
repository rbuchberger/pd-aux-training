# The logic for retrieving and filtering timecards has been placed in its own
# PORO class, located in app/presenters/timecards_presenter.rb
# I'm not sure if it's unnecessarily convoluted or good OO design. We'll see
# how big that class gets and maybe I'll put it back in the controller. 

class TimecardsController < ApplicationController

  before_action :get_user,    except: [:show]
  before_action :can_edit?,   except: [:index, :show, :destroy]
  before_action :can_see?,      only: [:index, :show]
  before_action :can_destroy?,  only: [:delete]
  before_action :get_timecard,  only: [:show, :edit, :update, :destroy]

  # This index action is only used for viewing a single users' timecards. 
  # There will be another created for admins & trainers who wish to view all 
  # timecards in a big list. 

  def index
    @date_range = get_timecards_params
    @timecards = TimecardsPresenter::FilteredTimecards.new(@date_range, @user)
  end
  
  def new
    @timecard = Timecard.new
  end
  
  def create
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
    @user = User.find(@timecard.user_id)
  end
  
  def edit
    
  end
  
  def update
    if @timecard.update(timecard_params)
      flash[:success] = "Timecard Updated!"
      redirect_to timecards_path
    else
      flash[:danger] = "Could not update timecard!"
      render edit_timecard_path(@timecard)
    end
  end
  
  def destroy
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
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end
  end
  
  def can_see?
    redirect_to root_path unless (current_user.admin? || current_user.trainer? || @user == current_user)
  end
  
  def can_edit?
    redirect_to root_path unless @user == current_user
  end
  
  def can_destroy?
    redirect_to root_path unless @user == current_user || current_user.admin?
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
    # This whole thing is ugly and I hate it. 
    p = params.permit(:user_id, :start, :finish)
    # Converted to a hash, and nil values removed. 
    p = p.to_h.symbolize_keys
    if !p[:start].blank? 
      p[:start] = p[:start].to_date 
    else
      p[:start] = Time.zone.now - 30.days
    end
    
    if !p[:finish].blank?
      p[:finish] = p[:finish].to_date
    else 
      p[:finish] = Time.zone.now
    end
    p
  end

end
