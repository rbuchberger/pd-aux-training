class TrainingVideosController < ApplicationController

  def new
    @training_video = TrainingVideo.new()
    authorize @training_video
  end
  
  def create 
    @training_video = TrainingVideo.new(training_video_params)
    authorize @training_video
    if @training_video.save
      flash[:success] = "Training video created!"
      redirect_to training_video_path(@training_video)
    else
      flash[:danger] = "Could not create video."
      render new_training_video_path
    end
  end
  
  def show 
    @training_video = get_video
    @user = current_user
    if @user.training_videos.exists?(@training_video.id)
      @training_record = @user.training_records.where(training_video_id: @training_video.id).first
    end
  end
  
  def edit
    @training_video = get_video
  end
  
  def update
    @training_video = get_video
    if @training_video.update(training_video_params)
      flash[:success] = "Training video updated!"
      redirect_to training_video_path(@training_video)
    else
      flash[:danger] = "Could not update video"
      render edit_training_video_path(@training_video)
    end
  end

  def index
    @user = current_user
    authorize TrainingVideo
    @training_videos_complete = @user.training_videos.all.order(:title)
    @training_videos_incomplete = TrainingVideo.all.order(:title).to_a - @training_videos_complete.to_a
  end

  def destroy
    @training_video = get_video
    if @training_video.delete
      flash[:success] = "Video deleted!"
      redirect_to training_videos_path
    else
      flash[:danger] = "Could not delete video."
      redirect_to training_video_path(@training_video)
    end
  end
  
  def users
    @training_video = get_video
    authorize @training_video
    @users_complete = @training_video.users.all.order(:last_name)
    # Surely there's a more efficient way to do this:
    @users_incomplete = (User.all.order(:last_name).to_a - @users_complete.to_a)  
  end
  
  private
  
  def get_video
    video = TrainingVideo.find(params[:id])
    authorize video
    video
  end
  
  def training_video_params
    params.require(:training_video).permit(:title, :description, :custom_start, :custom_end, :url)
  end
  
end
