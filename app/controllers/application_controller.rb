class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user! 
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,  keys: [:first_name, :last_name, :badge_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :badge_number])
  end
end
