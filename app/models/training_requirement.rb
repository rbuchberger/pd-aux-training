class TrainingRequirement < ApplicationRecord
  # Associations
  has_many :training_records, dependent: :destroy
  has_many :users, through: :training_records
  has_many :training_videos, dependent: :destroy
  accepts_nested_attributes_for :training_videos

  # Validations
  validates :title, presence: true, length: {maximum: 50}
  validates :description, length: {maximum: 1000}

  # Scopes
  default_scope { order: :title }
end
