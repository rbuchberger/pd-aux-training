class Timecard < ApplicationRecord
  include ActiveModel::Validations
  
  # Relationships:
  belongs_to :user
  
  # Validations
  validates :description, presence: true, length: {maximum: 250}
  validates :start, presence: true 
  validates :end, presence: true
  validates :user, presence: true
  validates_with TimecardValidator #Defined in concerns/timecard_validator.rb

  # Custom methods:
  
  # Length of workday 
  def duration
    self.end - self.start  
  end
  
  # Length of workday, in hours rounded to the nearest decimal place.
  def duration_hours(l=1)
   ( self.duration / 1.hour ).round(l)
  end
    
end

