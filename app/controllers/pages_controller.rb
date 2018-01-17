class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def home
    @user = current_user
    if @user
      @incomplete_training_count = Lesson.count - @user.completions.count
      @last_workday = @user.timecards.last
      @pending_count = User.where(role: :pending).count if policy(User).index?
      @bulletins = Bulletin.last(30)
    end
  end
end
