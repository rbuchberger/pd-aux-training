# Custom validator to handle complicated timecard validation
class TimecardValidator < ActiveModel::Validator
  def validate(timecard)
    @timecard = timecard

    check_time_presence

    # The other checks break if the times aren't present
    return if @timecard.errors.any?

    check_future
    check_duration
    check_overlap
  end

  private

  def check_overlap
    existing_timecards.each do |t|
      if (t.clock_in...t.clock_out).overlaps?(candidate_range) && t != @timecard
        @timecard.errors.add :clock_in, :overlap, message: 'These times overlap with an existing workday.'
      end
    end
  end

  def candidate_range
    @timecard.clock_in...@timecard.clock_out
  end

  def check_duration
    if length >= 24.hours
      @timecard.errors.add :clock_out, :too_long, message:
        'Workday is too long. If you really did work more than 24 hours, log 2 timecards.'
    elsif length.negative?
      @timecard.errors.add :clock_out, :negative, message:
        'I think you have your times swapped. End needs to come after start.'
    elsif length < 30.minutes
      @timecard.errors.add :clock_out, :too_short, message:
        "Don't log days shorter than 30 minutes."
    end
  end

  def length
    @timecard.duration
  end

  def check_future
    @timecard.errors[:clock_in] << "can't be in the future." if @timecard.clock_in >= Time.zone.now

    return unless @timecard.clock_out >= Time.zone.now + 24.hours

    @timecard.errors[:clock_out] << "can't be more than 24 hours in the future."
  end

  def check_time_presence
    @timecard.errors[:clock_in] << 'Must be present' unless @timecard.clock_in
    @timecard.errors[:clock_out] << 'Must be present' unless @timecard.clock_out
  end

  # Returns an array of ranges covering exising timecard time periods, +- 2 days
  # from candidate's clock in.
  def existing_timecards
    Timecard.where(
      user_id: @timecard.user_id,
      clock_in: @timecard.clock_in - 2.days...@timecard.clock_in + 2.days
    ) 
  end
end
