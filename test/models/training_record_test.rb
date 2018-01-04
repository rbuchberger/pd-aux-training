require 'test_helper'

class TrainingRecordTest < ActiveSupport::TestCase
  
  # Shouldn't save without a user
  test "save without user" do
    t = TrainingRecord.new(valid_training_record_params)
    t.user_id = ""
    assert_not t.save
  end
  
  # Shouldn't save without a video
  test "save without video" do
    t = TrainingRecord.new(valid_training_record_params)
    t.training_video_id = ""
    
    assert_not t.save
  end
  
  # Should be deleted when associated video is deleted
  test "delete with video" do
    video = training_videos(:one)
    user = users(:admin)
    user.training_records.create({
      training_video_id: video.id
    })
    
    assert_difference('TrainingRecord.count', -1) do
      video.destroy
    end
    
  end
  
  # Should be deleted when associated user is deleted
  test "delete with user" do
    video = training_videos(:one)
    user = users(:admin)
    user.training_records.create({
      training_video_id: video.id
    })
    
    assert_difference('TrainingRecord.count', -1) do
      user.destroy
    end
    
  end
end
