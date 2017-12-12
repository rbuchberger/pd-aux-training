module ApplicationHelper
  
  # Hash of bootstrap message types vs rails message types. 
  BOOTSTRAP_FLASH_MSG = {
    success: 'alert-success',
    error: 'alert-error',
    alert: 'alert-block',
    notice: 'alert-info'
  }
  
  # Converts rails flash messages to names that bootstrap expects, for proper styling
  def bootstrap_class_for(flash_type)
    BOOTSTRAP_FLASH_MSG.fetch(flash_type.to_sym, flash_type)
  end
  
  # Helper test for items which should only display to trainers and admins
  def is_trainer_or_admin?
    user_signed_in? && (current_user.trainer? || current_user.admin?)
  end

end