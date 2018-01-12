class TrainingRequirement < ApplicationRecord
  has_many :training_records, dependent: :destroy
  has_many :users, through: :training_records
  has_many :training_videos, dependent: :destroy
end
