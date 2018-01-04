require 'test_helper'

class TrainingRecordTest < ActiveSupport::TestCase
  
  # Shouldn't save without a user
  test "Save without user" do
    t = TrainingRecord.new({
      # user_id: 1,
      training_video_id: 1
    })
    
    assert_not t.save
  end
  
  # Shouldn't save without a video
  test "Save without video" do
    t = TrainingRecord.new({
      user_id: 1,
      # training_video_id: 1
    })
    
    assert_not t.save
  end

end
