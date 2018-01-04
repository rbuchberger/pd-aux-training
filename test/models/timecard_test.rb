require 'test_helper'

class TimecardTest < ActiveSupport::TestCase
  # Timecard should not save without a description
  test "Timecard save without description" do
    t = Timecard.new({
      # description: "I'm here!",
      start: Time.zone.today - 1.hours,
      end: Time.zone.today,
      user: users(:deputy)
      })
      assert_not t.save
  end
  
  # should not save without start value
  test "Timecard save without start" do
    t = Timecard.new({
      description: "I'm here!",
      # start: Time.zone.today - 1.hours,
      end: Time.zone.today,
      user: users(:deputy)
      })
      assert_not t.save
  end
  
  # should not save without end value
    test "Timecard save without end" do
    t = Timecard.new({
      description: "I'm here!",
      start: Time.zone.today - 1.hours,
      # end: Time.zone.today,
      user: users(:deputy)
      })
      assert_not t.save
  end
  
  # should not save without a user
    test "Timecard save without user" do
    t = Timecard.new({
      description: "I'm here!",
      start: Time.zone.today - 1.hours,
      end: Time.zone.today
      # user: users(:deputy)
      })
      assert_not t.save
  end
  
  # should not save if overlaps another timecard
    test "Timecard overlap" do
    Timecard.create({
      description: "I'm here!",
      start: Time.zone.today - 3.hours,
      end: Time.zone.today - 1.hours,
      user: users(:deputy)
      })
    t2 = Timecard.new({
      description: "I'm here!",
      start: Time.zone.today - 2.hours,
      end: Time.zone.today,
      user: users(:deputy)
      })
      assert_not t2.save
    end
    
  # should not save if more than 24 hours
  test "Timecard over 24 hours" do
    t = Timecard.new({
      description: "I'm here!",
      start: Time.zone.today - 25.hours,
      end: Time.zone.today,
      user: users(:deputy)
      })
      assert_not t.save
  end
  
  # should not save if less than 30 minutes
  test "Timecard less than 30 minutes" do
    t = Timecard.new({
      description: "I'm here!",
      start: Time.zone.today - 15.minutes,
      end: Time.zone.today,
      user: users(:deputy)
      })
      assert_not t.save
  end
  
  # should return a duration
  test "timecard duration" do
    t = timecards(:one).duration
    assert t.class == Float
    assert (30.minutes .. 24.hours).include? t
    
  end
  
  # should return a duration in hours
  test "timecard duration hours" do
    t = timecards(:one).duration_hours
    assert t.class == Float
    assert (0.5 .. 24.0).include? t
  end
  
  # Should be deleted when a user is deleted
  test "Delete with user" do
   user = User.create({
      first_name: 'Stan',
      last_name: 'Beaudry',
      badge_number: 'a99',
      email: 'stan@example.com',
      role: :admin,
      password: 123456,
      password_confirmation: 123456
    })
    
    user.timecards.create({
      description: 'Raiding Panties',
      start: Time.zone.now - 5.days,
      end: Time.zone.now - 5.days + 5.hours
      })
     
    t = Timecard.count
    user.destroy
    
    assert Timecard.count == t-1 
  end
end
