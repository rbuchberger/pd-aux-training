class TrainingVideo < ApplicationRecord
  
  # Validations
  validates :title, presence: true, length: {maximum: 30}
  validates :description, presence: true
  
  # Callbacks
#  before_save :grab_youtube_id
  
  private
  
  def grab_youtube_id
    # Sets self.yt_id to the result of some regular expression
  end
  
  
end
