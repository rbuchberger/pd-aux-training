class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def home
    if user_signed_in?
      @last_workday = current_user.timecards.last
      @pending_count = User.where(role: :pending).count if policy(User).index?
      @bulletins = Bulletin.all_cached
    end
  end

  def about
    
  end
end
