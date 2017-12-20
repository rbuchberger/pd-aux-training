class User < ApplicationRecord

  # Relationships:
  has_many :timecards, dependent: :destroy
  
  # Validations:
  # (Devise handles most of them. I only need to validate my custom fields) 
  validates :first_name, presence: true, length: {maximum: 50}
  validates :last_name, presence: true, length: {maximum: 50}
  validates :badge_number, presence: true, length: {maximum: 10}
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  # Enumerate roles for rails convenience.
  # They're stored in the database as integers. 
  enum role: [:pending, :deputy, :trainer, :admin]
  
  # Callbacks:
  after_create :set_default_role

  # Custom methods:
 
  # Add to a devise method, require admin approval of new users. 
  def active_for_authentication?
    super && !self.pending?
  end

  # Modify the devise flash message for unapproved users. 
  def inactive_message 
    if self.pending? 
      :not_approved 
    else 
      super # Don't modify the original message 
    end 
  end

  # Define the callback-- New users are set to pending.   
  def set_default_role
    self.role = :pending
  end


end
