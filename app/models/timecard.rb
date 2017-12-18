class Timecard < ApplicationRecord
  belongs_to :user
    # Calculates length of workday, in hours rounded to the nearest decimal place. 
    def duration
     ((self.end - self.start) / 1.hour ).round(1)
    end
 
end
