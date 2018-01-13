class Completion < ApplicationRecord
  # Each instance of this class represents the completion of one training video by one user. 
 
  belongs_to :lesson
  belongs_to :user
  
  validates :lesson_id, presence: true
  validates :user_id, presence: true
  
  # Allows viewing of deactivated users' records. 
  def user
    User.unscoped { super }
  end
end
