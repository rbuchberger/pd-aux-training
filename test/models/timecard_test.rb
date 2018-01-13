require 'test_helper'

class TimecardTest < ActiveSupport::TestCase
  # Timecard should not save without a description
  test "Timecard save without description" do
    t = Timecard.new(valid_timecard_params)
    t.description =  ""

    assert_not t.save
  end
  
  # should not save without start value
  test "Timecard save without clock in" do
    t = Timecard.new(valid_timecard_params)
    t.clock_in = nil 

    assert_not t.save
  end
  
  # should not save without end value
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
    t = Timecard.new(valid_timecard_params)
      assert_not t2.save
    end
    
  # should not save if more than 24 hours
  test "Timecard over 24 hours" do
    t = Timecard.new(valid_timecard_params)
      assert_not t.save
  end
  
  # should not save if less than 30 minutes
  test "Timecard less than 30 minutes" do
    t = Timecard.new(valid_timecard_params)
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
