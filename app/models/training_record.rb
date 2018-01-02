class TrainingRecord < ApplicationRecord
  # Each instance of this class represents the completion of one training
  # video by one user. 
  belongs_to :training_video
  belongs_to :user
end
