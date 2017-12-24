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
  before_save :format_string_fields
  after_create :set_default_role

  # Custom methods:
 
 # Returns full name in a view-friendly format. 
  def first_last(l = 25)
    "#{self.first_name} #{self.last_name}".truncate(l, omission: "...")
  end
  
  # Returns full name in a different view friendly format. 
  def last_first(l = 25)
    "#{self.last_name}, #{self.first_name}".truncate(l, omission: "...")
  end
  
  # Admins are trainers too. 
  def trainer?
    super || self.admin?
  end
 
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
private
  # Define the callback-- New users are set to pending.   
  def set_default_role
    self.role = :pending
  end
  
  def format_string_fields
    self.first_name = self.first_name.capitalize
    self.last_name = self.last_name .capitalize
    self.badge_number = self.badge_number.upcase
  end
end
