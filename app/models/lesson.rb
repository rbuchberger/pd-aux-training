class Lesson < ApplicationRecord
  # Associations
  has_many :completions, dependent: :destroy
  has_many :users, through: :completions
  # It'll be a has_one relationship for now, until I add functionality to support multiple types of training resources
  has_one :video, dependent: :destroy, autosave: true, inverse_of: :lesson 
  accepts_nested_attributes_for :video

  # Validations
  validates :title, presence: true, length: {maximum: 50}
  validates :description, length: {maximum: 1000}

  # Scopes
  default_scope {order( :title )} 
end
