class TrainingVideo < ApplicationRecord
  # Associations
  belongs_to :training_requirement

  # Validations
  validates :title, presence: true, length: {maximum: 50}
  validates :url, presence: true
  validates :description, length: {maximum: 1000}
  validates_format_of :url, with: @@url_regex, 
    message: ": I'm sorry, I don't know what to do with that address."
  
  
  # Custom methods
  def yt_id
    url_regex = /(youtu\.be\/|youtube\.com\/(watch\?(.*&)?v=|(embed|v)\/))([^\?&"'>]+)/
    url_regex.match(self.url)[5]
  end
  
end
