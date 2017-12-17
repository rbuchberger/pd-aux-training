class Timecard < ApplicationRecord
  belongs_to :user
  
  # Calculates length of workday, in hours rounded to the nearest decimal place. 
  def timecard_length_hours
   ((self.end - self.start) / 1.hour ).round(1)
  end
end
