# Custom validator to handle complicated timecard validation
class TimecardValidator < ActiveModel::Validator
  
  def validate(timecard)
    
    timecard.errors[:start] << "Must be present" unless timecard.start
    timecard.errors[:end] << "Must be present" unless timecard.end
    
    unless timecard.errors.any? # All of this breaks if start and end times aren't supplied. 
      if timecard.start >= Time.zone.now
         timecard.errors[:start] << "can't be in the future." 
      end
      
      if timecard.end >= Time.zone.now + 24.hours
        timecard.errors[:end] << "can't be more than 24 hours in the future." 
      end
      
      # Gonna use length several times. 
      length = timecard.duration
      if length >= 24.hours
         timecard.errors[:base] << 
         "Workday is too long. If you really did work more than 24 hours, log 2 timecards." 
      elsif length < 0
        timecard.errors[:base] << 
        "I think you have your times swapped. End needs to come after start."
      elsif length >= 0 && length < 30.minutes
        timecard.errors[:base] << 
        "Don't log days shorter than 30 minutes."
      end
      
      # Get all the user's timecards 
      existing_user_timecards = Timecard.where(user_id: timecard.user_id)
      # Check if they overlap the new card
      overlaps_existing = false
      existing_user_timecards.each do |t| 
        if ( (t[:start]..t[:end]).overlaps? (timecard[:start]..timecard[:end]) ) && t != timecard
         overlaps_existing = true  
        end
      end
      if overlaps_existing
        timecard.errors[:base] << "These times overlap with an existing workday."
      end
    end
  end
  
end