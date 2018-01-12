class TrainingRecordsController < ApplicationController
  
  def index
    authorize TrainingRecord
    @training_requirements = TrainingRequirement.all.order(:title).includes(:training_records)
    @users = User.all.order(:last_name).includes(:training_records)
  end
  
  def create
    @training_requirement = TrainingRequirement.find(params[:id]) 
    @user = current_user
    @training_record = TrainingRecord.new(
      training_requirement_id: @training_requirement.id,
      user_id: @user.id
    )
    authorize @training_record
    if @training_record.save
      flash[:success] = "You have successfully completed #{@training_requirement.title}!"
      redirect_to training_requirements_path
    else
      flash[:danger] = "Could not complete training record"
      redirect_to training_requirements_path(@training_requirement)
    end
    
  end
  
  def destroy 
    @training_record = TrainingRecord.find(params[:id])
    authorize @training_record
    if @training_record.destroy
      flash[:success] = "Training record deleted."
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Could not delete training record."
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
  
  def training_record_params
    params.require(:training_requirement))
  end
  
end
