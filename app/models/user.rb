# frozen_string_literal: true

# Are you happy, rubocop?
class User < ApplicationRecord
  # Associations:
  has_many :timecards, dependent: :destroy
  has_many :completions, dependent: :destroy
  has_many :lessons, through: :completions
  has_many :bulletins

  # Validations:
  # (Devise handles most of them. I only need to validate my custom fields)
  # Validates first and last names, 30 characters, a-z/A-Z, hyphens, and spaces.
  NAME_REGEX = /\A[a-z,\-, ]{1,30}\z/i.freeze
  validates_format_of :first_name, with: NAME_REGEX
  validates_format_of :last_name,  with: NAME_REGEX
  # Validates badge number, Either X-(2 digits) with or without dash. If no
  # dash, add it later.
  validates_format_of :badge_number, with: %r{\A(x\-?\d{1,2}|7\d{2}|N/?A)\z}i

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Callbacks:
  before_save :format_string_fields
  after_create :set_default_role

  # Enumerate roles for convenience. They're stored in the database as
  # integers.
  enum role: %i[pending deputy trainer admin]

  # Custom methods:

  # Returns full name in a view-friendly format.
  def first_last(length = 25)
    "#{first_name} #{last_name}".truncate(length, omission: '...')
  end

  # Returns full name in a different view friendly format.
  def last_first(length = 25)
    "#{last_name}, #{first_name}".truncate(length, omission: '...')
  end

  # Admins are trainers too.
  def trainer?
    super || admin?
  end

  # Devise method overwrite - Makes sure user is approved and not deactivated.
  def active_for_authentication?
    super && !pending? && !deleted_at
  end

  # Modify the devise flash message for unapproved users.
  def inactive_message
    if pending?
      :not_approved
    elsif deleted_at
      :deleted_account
    else
      super
    end
  end

  # Soft delete method, used to overwrite the default destroy method and stop
  # users from deleting their accounts. Ensures the last admin can't deactivate
  # themselves.
  def deactivate
    if admin? && User.where(role: :admin).count <= 1
      false
    else
      update_attributes(deleted_at: Time.zone.now, role: :deputy)
    end
  end

  def reactivate
    update_attribute(:deleted_at, nil)
  end

  # Override the default destroy method to ensure the last admin doesn't delete
  # their account:
  def destroy
    if admin? && User.where(role: :admin).count <= 1
      false
    else
      super
    end
  end

  def approve
    if pending?
      update(role: :deputy)
    else
      false
    end
  end

  def reject
    if pending?
      destroy
    else
      false
    end
  end

  private

  # Callback: New users are set to pending.
  def set_default_role
    self.role = :pending
  end

  # Callback: Fixes capitalization and formatting.
  def format_string_fields
    self.first_name   = format_name(first_name, false)
    self.last_name    = format_name(last_name, true)
    self.badge_number = format_badge(badge_number)
  end

  def format_name(name, is_last = false)
    # Capitalization:
    name = name.downcase.split.map(&:capitalize).join(' ')
    # replace multiple spaces with a single one:
    name = name.gsub(/ {2,}/, ' ')
    # remove spaces from the end:
    name = name.gsub(/ \z/, '')
    if is_last
      # Uppercase for I, II, IV, etc:
      name = name.gsub(/[i,v,x]{1,3}\z/i, &:upcase)
    end
    name
  end

  def format_badge(badge)
    # Uppercase badge number:
    badge = badge.upcase
    # Add a dash to the badge number (X01 -> X-01):
    badge = badge.gsub(/X(?<num>\d{1,2})/, 'X-\k<num>')
    # Strip leading 0s from X-Badges (i.e. X-01 -> X-1):
    badge = badge.gsub(/X-0(?<num>\d)/, 'X-\k<num>')
    # Change NA to N/A for consistency:
    badge.gsub(/NA/, 'N/A')
  end
end
