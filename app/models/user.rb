class User < ApplicationRecord

  # Relationships:
  has_many :timecards, dependent: :destroy
  has_many :completions, dependent: :destroy
  has_many :lessons, through: :completions
  has_many :bulletins
  
  # Validations:
  # (Devise handles most of them. I only need to validate my custom fields) 
  # Validates first and last names, 50 characters, a-z/A-Z, hyphens, and spaces. Fix casing afterwards
  name_regex = /\A[a-z,\-, ]{1,30}\z/i
  validates_format_of :first_name, with: name_regex 
  validates_format_of :last_name,  with: name_regex
  # Validates badge number, Either X-(2 digits) with or without dash. If no dash, add it later. 
  validates_format_of :badge_number, with: /\A(x\-?\d{1,2}|7\d{2}|N\/?A)\z/i 
  
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

  # Scopes:
  def self.default_scope 
    User.where(deleted_at: nil).order(:last_name)
  end
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
    # Capitalization
    self.first_name = self.first_name.downcase.split.map{|w| w.capitalize}.join(' ')
    # replace multiple spaces with a single one.
    self.first_name = self.first_name.gsub(/ {2,}/, " ")
    # remove spaces from the end
    self.first_name = self.first_name.gsub(/ \z/, "")
    # Capitalize last name
    self.last_name = self.last_name.downcase.split.map{|w| w.capitalize}.join(' ')
    # Replace multiple spaces with a single one.
    self.last_name = self.last_name.gsub(/ {2,}/, " ")
    # Remove spaces from the end
    self.last_name = self.last_name.gsub(/ *\z/, "")
    # Uppercase for I, II, IV, etc
    self.last_name = self.last_name.gsub(/[i,v,x]{1,3}\z/i) {|g| g.upcase}
    # Uppercase badge number
    self.badge_number = self.badge_number.upcase
    # Add a dash to the badge number, if it's an X-number format. 
    self.badge_number = self.badge_number.gsub(/X(?<num>\d{1,2})/, 'X-\k<num>' )
    # Change NA to N/A for consistency. 
    self.badge_number = self.badge_number.gsub(/NA/, 'N/A')
  end
end
