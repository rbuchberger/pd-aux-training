class TrainingRequirement < ApplicationRecord
  # Associations
  has_many :training_records, dependent: :destroy
  has_many :users, through: :training_records
  # It'll be a has_one relationship for now, until I add functionality to support multiple types of training resources
  has_one :training_video, dependent: :destroy
  accepts_nested_attributes_for :training_video

  # Validations
  validates :title, presence: true, length: {maximum: 50}
  validates :description, length: {maximum: 1000}

  # Scopes
  default_scope { order: :title }
end
