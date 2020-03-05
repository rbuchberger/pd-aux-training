# Custom validator to handle complicated timecard validation
class TimecardValidator < ActiveModel::Validator
  def validate(timecard)
    timecard.errors[:clock_in] << 'Must be present' unless timecard.clock_in
    timecard.errors[:clock_out] << 'Must be present' unless timecard.clock_out

    unless timecard.errors.any? # All of this breaks if start and end times aren't supplied.
      if timecard.clock_in >= Time.zone.now
        timecard.errors[:clock_in] << "can't be in the future."
      end

      if timecard.clock_out >= Time.zone.now + 24.hours
        timecard.errors[:clock_out] << "can't be more than 24 hours in the future."
      end

      # Gonna use length several times.
      length = timecard.duration
      if length >= 24.hours
        timecard.errors[:base] <<
          'Workday is too long. If you really did work more than 24 hours, log 2 timecards.'
      elsif length < 0
        timecard.errors[:base] <<
          'I think you have your times swapped. End needs to come after start.'
      elsif length >= 0 && length < 30.minutes
        timecard.errors[:base] <<
          "Don't log days shorter than 30 minutes."
      end

      # Enables users to log subsequent timecards without overlap rejection.
      # clock_in = timecard.clock_in + 1.second
      # clock_out -= timecard.clock_out - 1.second

      # Get all the user's timecards
      existing_user_timecards = Timecard.where(user_id: timecard.user_id)
      # Check if they overlap the new card
      existing_user_timecards.each do |t|
        if ((t.clock_in...t.clock_out).overlaps? (timecard.clock_in...timecard.clock_out)) && t != timecard
          timecard.errors[:base] << 'These times overlap with an existing workday.'
        end
      end
    end
  end
end
