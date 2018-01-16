class Video < ApplicationRecord

  @@url_regex = /(youtu\.be\/|youtube\.com\/(watch\?(.*&)?v=|(embed|v)\/))([^\?&"'>]+)/
  

  #Associations
  belongs_to :lesson, inverse_of: :video

  # Validations
  validates :url, presence: true
  validates_format_of :url, with: @@url_regex, 
    message: ": I'm sorry, I don't know what to do with that address."
  
  # Custom methods
  def yt_id
    @@url_regex.match(self.url)[5]
  end
  
  
end
