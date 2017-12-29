class TrainingVideo < ApplicationRecord
  
  # Validations
  validates :title, presence: true, length: {maximum: 30}
  validates :description, presence: true
  validates :url, presence: true
  
  # Callbacks
  before_save :grab_youtube_id
  
  private
  
  def grab_youtube_id
    # Pulls the youtube video ID out of the url. TODO - update this with something less picky
    yt_regexp = /(youtu\.be\/|youtube\.com\/(watch\?(.*&)?v=|(embed|v)\/))([^\?&"'>]+)/
    self.yt_id = yt_regexp.match(self.url)[5]
  end
  
  
end
