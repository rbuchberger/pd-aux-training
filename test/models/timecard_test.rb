require 'test_helper'

class TimecardTest < ActiveSupport::TestCase
  # Create new timecard
  test "Timecard create" do

    t = Timecard.new(valid_timecard_params)
    
    assert t.save
    assert_equal t.clock_in, Time.zone.new(2017,12,31,12,30)
    assert_equal t.clock_out, Time.zone.new(2018,01,01,2,30)

  end

  # Update existing timecard
  test "Timecard update" do
    
    t = Timecard.new(valid_timecard_params)
    puts t
    t.save
    t.field_clock_in_date = ('2016-11-20')
    t.field_clock_in_time = {1 => 2018,2 => 02,3 => 01, 4 => 15, 5 => 15}
    t.field_clock_out_time = {1 => 2018, 2 => 02, 3 => 01, 4 => 19, 5 => 45 }

    assert t.update
    assert_equal t.clock_in, Time.zone.new(2016,11,20,15,15)
    assert_equal t.clock_out, Time.zone.new(2016,11,20,19,45)
  end


  # Timecard should not save without a description
  test "Timecard save without description" do
    t = Timecard.new(valid_timecard_params)
    t.description =  ""

    assert_not t.save
  end
  
  # should not save without clock in time
  test "Timecard save without clock in" do
    t = Timecard.new(valid_timecard_params)
    t.clock_in = nil 

    assert_not t.save
  end
  
  # should not save without clock out time
    test "Timecard save without clock out" do
    t = Timecard.new(valid_timecard_params)
    t.clock_out = nil

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
      clock_in: Time.zone.now - 30.days,
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
    
  # should not save if more than 24 hours
  test "Timecard over 24 hours" do
    t = Timecard.new(valid_timecard_params)
    t.field_clock_out_time = t.field_clock_in_time + 25.hours

    assert_not t.save
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

    assert t.class == Float
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
