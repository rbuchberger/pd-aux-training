class User < ApplicationRecord

  # Relationships:
  has_many :timecards, dependent: :destroy
  has_many :training_records, dependent: :destroy
  has_many :training_videos, through: :training_records
  
  # Validations:
  # (Devise handles most of them. I only need to validate my custom fields) 
  validates :first_name, presence: true, length: {maximum: 50}
  validates :last_name, presence: true, length: {maximum: 50}
  validates :badge_number, presence: true, length: {maximum: 4}
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  # Enumerate roles for rails convenience.
  # They're stored in the database as integers. 
  enum role: [:pending, :deputy, :trainer, :admin]
  
  # Callbacks:
  before_save :format_string_fields
  after_create :set_default_role

  # Custom methods:
 
 # Returns full name in a view-friendly format. 
  def first_last(length = 25)
    "#{self.first_name} #{self.last_name}".truncate(length, omission: "...")
  end
  
  # Returns full name in a different view friendly format. 
  def last_first(length = 25)
    "#{self.last_name}, #{self.first_name}".truncate(length, omission: "...")
  end
  
  # Admins are trainers too. 
  def trainer?
    super || self.admin?
  end
 
  # Devise method overwrite - Makes sure user is approved and makes sure user isn't deactivated.
  def active_for_authentication?
    super && !self.pending? && !deleted_at
  end

  # Modify the devise flash message for unapproved users. 
  def inactive_message 
    if self.pending? 
      :not_approved 
    elsif self.deleted_at
	    :deleted_account
    else
      super
    end 
  end
  # Soft delete method, used to overwrite the default destroy method and stop users from deleting their accounts. 
  def soft_delete
	  update_attribute(:deleted_at, Time.zone.now)
  end

private
  # Callback: New users are set to pending.   
  def set_default_role
    self.role = :pending
  end
  
  # Callback: Fixes capitalization and formatting. 
  def format_string_fields
    self.first_name = self.first_name.downcase.capitalize
    self.last_name = self.last_name.downcase.capitalize
    self.badge_number = self.badge_number.upcase
  end
end
