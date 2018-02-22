module DeviseHelper
  def devise_error_messages!
    render partial: 'application/validation_fails', locals: {record: resource}
  end
end
