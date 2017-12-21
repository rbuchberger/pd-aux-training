# Custom validator to handle complicated timecard validation
class TimecardValidator < ActiveModel::Validator
  
  def validate(timecard)
    
    if timecard.start >= Time.zone.now
       timecard.errors[:start] << "can't be in the future." 
    end
    
    if timecard.end >= Time.zone.now + 24.hours
      timecard.errors[:end] << "can't be more than 24 hours in the future." 
    end
    
    # Gonna use length several times. 
    length = timecard.end - timecard.start
    if length >= 24.hours
       timecard.errors[:base] << 
       "Workday is too long. If you really did work more than 24 hours, log 2 timecards." 
    elsif length < 0
      timecard.errors[:base] << 
      "I think you have your times swapped. End needs to happen after start."
    elsif length >= 0 && length < 30.minutes
      timecard.errors[:base] << 
      "Workday can't be shorter than 30 minutes."
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