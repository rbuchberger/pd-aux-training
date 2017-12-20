class Timecard < ApplicationRecord
  include ActiveModel::Validations
  # Relationships:
  belongs_to :user
  
  # Validations
  validates :description, length: {maximum: 100}
  validates :start, presence: true 
  validates :end, presence: true
  validates :user, presence: true
  validates_with TimecardValidator

  # Custom methods:
  
  def duration
    # Calculates length of workday, in hours rounded to the nearest decimal place.
   ((self.end - self.start) / 1.hour ).round(1)
  end

end

# Custom validator to handle complicated timecard validation
class TimecardValidator < ActiveModel::Validator
  
  def validate(timecard)
    
    if timecard.start >= Time.zone.now
       timecard.errors[:start] << "You can't clock in in the future." 
    end
    
    if timecard.end >= Time.zone.now + 24.hours
      timecard.errors[:end] << "You can't clock out more than 24 hours in the future." 
    end
   
    if (timecard.end - timecard.start) >= 24.hours
       timecard.errors[:base] << "Workday is too long. If you really did work more than a 24 hour stretch, log 2 timecards." 
    end
    
    if (timecard.end - timecard.start) <= 0
      timecard.errors[:base] << "Your workday must start before it ends."
    end
    
    # Get all the user's timecards 
    existing_user_timecards = Timecard.where(user_id: timecard[:user_id])
    # Check if they overlap the new card
    overlaps_existing = false
    existing_user_timecards.each do |t| 
      overlaps_existing = true if (t[:start]..t[:end]).overlaps? (timecard[:start]..timecard[:end]) 
    end
      
    if overlaps_existing
      timecard.errors[:base] << "These times overlap with an existing workday."
    end
    
  end
  
end