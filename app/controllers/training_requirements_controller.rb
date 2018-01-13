class TrainingRequirementsController < ApplicationController
  def new
    @training_requirement = TrainingRequirement.new()
    authorize @training_requirement
    @training_requirement.training_video.new  
  end
  
  def create 
    @training_requirement = TrainingRequirement.new(training_requirement_params)
    authorize @training_requirement
    
    if @training_requirement.save
      flash[:success] = "Training video created!"
      redirect_to training_requirement_path(@training_requirement)
    else
      flash[:danger] = "Could not create video."
      render new_training_requirement_path
    end
  end
  
  def show 
    @training_requirement = get_training_requirement
    @user = current_user
    if @user.training_requirement.exists?(@training_requirement.id)
      @training_record = @user.training_records.where(training_requirement_id: @training_requirement.id).first
    end
  end
  
  def edit
    @training_requirement = get_training_requirement
  end
  
  def update
    @training_requirement = get_training_requirement
    if @training_requirement.update(training_requirement_params)
      flash[:success] = "Training video updated!"
      redirect_to training_requirement_path(@training_requirement)
    else
      flash[:danger] = "Could not update video"
      render edit_training_requirement_path(@training_requirement)
    end
  end

  def index
    @user = current_user
    authorize TrainingRequirement
    @training_requirements_complete = @user.training_requirements.all
    @training_requirements_incomplete = TrainingRequirement.all.order(:title).to_a - @training_requirements_complete.to_a
  end

  def destroy
    @training_requirement = get_training_requirement
    if @training_requirement.delete
      flash[:success] = "Video deleted!"
      redirect_to training_requirements_path
    else
      flash[:danger] = "Could not delete video."
      redirect_to training_requirement_path(@training_requirement)
    end
  end
  
  def users
    @training_requirement = get_training_requirement
    authorize @training_requirement
    @users_complete = @training_requirement.users.all
    # Surely there's a more efficient way to do this:
    @users_incomplete = (User.all.to_a - @users_complete.to_a)  
  end
  
  private
  
  def get_training_requirement
    training_requirement = TrainingRequirement.find(params[:id])
    authorize training_requirement
    training_requirement
  end
  
  def training_requirement_params
    params.require(:training_requirement).permit(:title, :description, training_video_attributes: [ :custom_start, :custom_end, :url])
  end
  
end
