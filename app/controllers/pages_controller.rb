class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def home
    @pending = User.where(role: :pending)
  end
end
