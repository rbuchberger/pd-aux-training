class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_global_variables
  
  # Pundit error handling
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,  keys: [:first_name, :last_name, :badge_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :badge_number])
  end

  def set_global_variables(included = [])
    if user_signed_in? 
      @current_user = User.includes(included).find(current_user.id)
    else
      @current_user = false
    end
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
  
end
