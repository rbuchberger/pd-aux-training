class Bulletin < ApplicationRecord
  # Associations
  belongs_to :user

  # Validations
  validates :title, presence: true, length: {maximum: 50}
  validates :description, length: {maximum: 1000}

  # Scopes
  default_scope {where(:created_at < Time.zone.today - 30.days )} 
end
