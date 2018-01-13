class AddTrainingRequirementToTrainingVideos < ActiveRecord::Migration[5.1]
  def change
    add_reference :training_videos, :training_requirement, foreign_key: true
  end
end
