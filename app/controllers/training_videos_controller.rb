class TrainingVideosController < ApplicationController
  
  before_action: :trainer_check, except: [index, show]
  
  def new
    @video = TrainingVideo.new()
  end
  
  def create 
    @video = TrainingVideo.new(training_video_params)
    if @video.save
      flash[:success] = "Training video created!"
      redirect_to training_video_path(@video)
    else
      flash[:danger] = "Could not create video."
      render new_training_video_path
  end
  
  def show 
    @video = Video.find(:id)
  end
  
  def edit
    @video = Video.find(:id)
  end
  
  def update
    @video = Video.find(:id)
    if @video.update(training_video_params)
      flash[:success] = "Training video updated!"
      redirect_to training_video_path(@video)
    else
      flash[:danger] = "Could not update video"
      render edit_training_video_path(@video)
    end
  end

  def index
    @videos = TrainingVideo.all
  end

  def delete
    @video = Video.find(:id)
    if @video.delete
      flash[:success] = "Video deleted!"
      redirect_to training_videos_path
    else
      flash[:danger] = "Could not delete video."
      redirect_to training_video_path(@video)
    end
  end
  
  private
  
  def trainer_check
    redirect_to root_path unless current_user.trainer?
  end
  
  def training_video_params
    params.require(:training_video).permit(:title, :description, :custom_start, :custom_end)
  end
  
end
