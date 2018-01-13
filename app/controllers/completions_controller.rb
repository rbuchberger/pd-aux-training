class CompletionsController < ApplicationController
  
  def index
    authorize Completion
    @lessons = Lesson.all.order(:title).includes(:completions)
    @users = User.all.order(:last_name).includes(:completions)
  end
  
  def create
    @lesson = Lesson.find(params[:id]) 
    @user = current_user
    @completion = Completion.new(
      lesson_id: @lesson.id,
      user_id: @user.id
    )
    authorize @completion
    if @completion.save
      flash[:success] = "You have successfully completed #{@lesson.title}!"
      redirect_to lessons_path
    else
      flash[:danger] = "Could not complete training record"
      redirect_to lessons_path(@lesson)
    end
    
  end
  
  def destroy 
    @completion = Completion.find(params[:id])
    authorize @completion
    if @completion.destroy
      flash[:success] = "Training record deleted."
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Could not delete training record."
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
  
  def completion_params
    params.require(:lesson)
  end
  
end
