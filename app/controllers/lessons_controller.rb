class LessonsController < ApplicationController
  def new
    @lesson = Lesson.new()
    authorize @lesson
    @lesson.build_video  
  end
  
  def create 
    @lesson = Lesson.new(lesson_params[:lesson])
    authorize @lesson
    if @lesson.save 
      flash[:success] = "Training video created!"
      redirect_to lesson_path(@lesson)
    else
      flash[:danger] = "Could not create video."
      render action: 'new' 
    end
  end
  
  def show 
    @lesson = get_lesson
    @user = current_user
    if @user.lessons.exists?(@lesson.id)
      @completion = @user.completions.where(lesson_id: @lesson.id).first
    end
  end
  
  def edit
    @lesson = get_lesson
  end
  
  def update
    @lesson = get_lesson
    if @lesson.update(lesson_params[:lesson])
      flash[:success] = "Training video updated!"
      redirect_to lesson_path(@lesson)
    else
      flash[:danger] = "Could not update video"
      render edit_lesson_path(@lesson)
    end
  end

  def index
    @user = current_user
    authorize Lesson
    @lessons_complete = @user.lessons.all
    @lessons_incomplete = Lesson.all.order(:title).to_a - @lessons_complete.to_a
  end

  def destroy
    @lesson = get_lesson
    if @lesson.delete
      flash[:success] = "Video deleted!"
      redirect_to lessons_path
    else
      flash[:danger] = "Could not delete video."
      redirect_to lesson_path(@lesson)
    end
  end
  
  def users
    @lesson = get_lesson
    authorize @lesson
    @users_complete = @lesson.users.all
    # Surely there's a more efficient way to do this:
    @users_incomplete = (User.all.to_a - @users_complete.to_a)  
  end
  
  private
  
  def get_lesson
    lesson = Lesson.find(params[:id])
    authorize lesson
    lesson
  end
  
  def lesson_params
    params.permit(lesson: [:title, :description, video_attributes: [ :url ] ])
    # params.require(:lesson)
      # .permit( :title, :description, 
              # video_attributes: [ :custom_start, :custom_end, :url] 
             # )
  end
  
end
