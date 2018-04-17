class Preference < ApplicationRecord
  # This model stores user preferences, for things such as email notifications.
  # Each user has one and only one. 

  # This model so far is nothing but a set of boolean flags. If it becomes more
  # complicated in the future, I will add validations and tests. 

  belongs_to :user, inverse_of: :preference

  def set_defaults(role)

    if role == 'admin' || 'trainer'
      self.user_signup_notify = true
      self.user_deactivate_notify = true
    end

    self.bulletin_notify = true
    self.document_notify = false

  end

  def disable_all_emails
    self.user_signup_notify     = false
    self.user_deactivate_notify = false
    self.bulletin_notify        = false
    self.document_notify        = false
  end

end
