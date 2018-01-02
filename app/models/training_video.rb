class TrainingVideo < ApplicationRecord
  has_many :users, through: :training_records, dependent: :destroy
  
  # Class Variables
  @@url_regex = /(youtu\.be\/|youtube\.com\/(watch\?(.*&)?v=|(embed|v)\/))([^\?&"'>]+)/

  # Validations
  validates :title, presence: true, length: {maximum: 50}
  validates :url, presence: true
  validates :description, length: {maximum: 1000}
  validates_format_of :url, with: @@url_regex, 
    message: ": I'm sorry, I don't know what to do with that address."
  
  # Callbacks
  before_save :grab_youtube_id
  
  private
  
  def grab_youtube_id
    # Pulls the youtube video ID out of the url.
    self.yt_id = @@url_regex.match(self.url)[5] 
  end
  
end