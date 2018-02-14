require 'test_helper'

class TimecardTest < ActiveSupport::TestCase
  # Create new timecard
  test "Timecard create" do

    t = Timecard.new(valid_timecard_params)
    assert t.save
    assert compare_datetimes t.clock_in, Time.new(2015,12,31,12,30)
    assert compare_datetimes t.clock_out, Time.new(2016,01,01,2,30)

  end

  # Update existing timecard
  test "Timecard update" do
    
    t = Timecard.create(valid_timecard_params)
    t.field_clock_in_date = Date.new(2016,11,20) 
    t.field_clock_in_time = Time.new(2018,01,01,15,15)
    t.field_clock_out_time = Time.new(2018,01,01,19,45)

    assert t.save
    assert compare_datetimes t.clock_in, Time.new(2016,11,20,15,15)
    assert compare_datetimes t.clock_out, Time.new(2016,11,20,19,45)
  end


  # Timecard should not save without a description
  test "Timecard save without description" do
    t = Timecard.new(valid_timecard_params)
    t.description =  ""

    assert_not t.save
  end
  
  # should not save without a user
  test "Timecard save without user" do
    t = Timecard.new(valid_timecard_params)
    t.user_id = nil
    
    assert_not t.save
  end
  
  # should not save if overlaps another timecard
  test "Timecard overlap" do
    t1 = Timecard.create({
      clock_in:  Time.zone.now - 30.days,
      clock_out: Time.zone.now - 30.days + 8.hours,
      description: 'Test 1',
      user_id: 1 
    })
    t2 = Timecard.new({
      clock_in: Time.zone.now - 30.days + 1.hour,
      clock_out: Time.zone.now - 30.days + 7.hours,
      description: 'Test 2',
      user_id: 1 
    })

    assert_not t2.save
  end
  
  # should not save if less than 30 minutes
  test "Timecard less than 30 minutes" do
    t = Timecard.new(valid_timecard_params)
    t.field_clock_out_time = t.field_clock_in_time + 29.minutes

      assert_not t.save
  end
  
  # should return a duration
  test "timecard duration" do
    t = timecards(:deputy).duration

    assert t.class == Float
    assert (30.minutes .. 24.hours).include? t
    
  end
  
  # should return a duration in hours
  test "timecard duration hours" do
    t = timecards(:deputy).duration_hours

    assert_equal t.class, Float
    assert (0.5 .. 24.0).include? t
  end
  
  # Should be deleted when a user is deleted
  test "Delete with user" do
    user = users(:deputy) 
    t = user.timecards.count * -1

    assert_difference('Timecard.count', t) do
      user.destroy
    end
    
  end
end
