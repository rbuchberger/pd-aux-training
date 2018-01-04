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
  
  # should return a duration in hours
  
end
