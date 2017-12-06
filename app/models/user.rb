class User < ApplicationRecord
 
    # Enumerate roles for rails convenience; they're stored in the database as integers. 
    enum role: {pending: 0, deputy: 1, trainer: 2, admin: 3}
    after_initialize :set_default_role, :if => :new_record? 

    # Set default role to pending for new users. 
    def set_default_role
      self.role ||= :pending
    end

 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  # Add to a devise method, require admin approval of new users. 
  def active_for_authentication?
    super && user.role != :pending
  end

  # Modify the devise flash message for unapproved users. 
  def inactive_message 
    if self.role == :pending 
      :not_approved 
    else 
      super # Use whatever other message 
    end 
  end

end
