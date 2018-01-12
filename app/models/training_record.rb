class TrainingRecord < ApplicationRecord
  # Each instance of this class represents the completion of one training video by one user. 
 
  belongs_to :training_video
  belongs_to :user
  
  validates :training_video_id, presence: true
  validates :user_id, presence: true
  
  # Allows viewing of deactivated users' records. 
  def user
    User.unscoped { super }
  end
end
