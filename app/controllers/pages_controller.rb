class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def home
    @user = current_user
    if @user
      @incomplete_video_count = TrainingVideo.count - @user.training_records.count
      @last_workday = @user.timecards.last
      @pending_count = User.where(role: :pending).count if policy(User).index?
    end
  end
end
