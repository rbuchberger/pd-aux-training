module ApplicationHelper
  
  # Hash of bootstrap message types vs rails message types. 
  BOOTSTRAP_FLASH_MSG = {
    success: 'success',
    error: 'warning',
    alert: 'danger',
    notice: 'info'
  }
  
  # Converts rails flash messages to names that bootstrap expects, for proper styling
  def bootstrap_class_for(flash_type)
    BOOTSTRAP_FLASH_MSG.fetch(flash_type.to_sym, flash_type)
  end
  

end