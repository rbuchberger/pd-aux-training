require 'test_helper'

class TrainingRecordTest < ActiveSupport::TestCase
  
  # Shouldn't save without a user
  test "save without user" do
    t = TrainingRecord.new({
      # user_id: 1,
      training_video_id: 1
    })
    
    assert_not t.save
  end
  
  # Shouldn't save without a video
  test "save without video" do
    t = TrainingRecord.new({
      user_id: 1,
      # training_video_id: 1
    })
    
    assert_not t.save
  end
  
  
  # Should be deleted when associated video is deleted
  test "delete with video" do
    video = TrainingVideo.create({
      title: "How to apply handcuffs", 
      description: "I know someone who's into this stuff.", 
      url: "https://www.youtube.com/watch?v=PdDu9T1EbWM", 
    })
    
    user = User.create({
      first_name: 'Stan',
      last_name: 'Beaudry',
      badge_number: 'a99',
      email: 'stan@example.com',
      role: :admin,
      password: 123456,
      password_confirmation: 123456
    })
    
    user.training_records.create({
      training_video_id: video.id
    })
    
    t = TrainingRecord.count
    video.destroy
    
    assert TrainingRecord.count == t-1
  end
  
  # Should be deleted when associated user is deleted
  test "delete with user" do
    video = TrainingVideo.create({
      title: "How to apply handcuffs", 
      description: "I know someone who's into this stuff.", 
      url: "https://www.youtube.com/watch?v=PdDu9T1EbWM", 
    })
    
    user = User.create({
      first_name: 'Stan',
      last_name: 'Beaudry',
      badge_number: 'a99',
      email: 'stan@example.com',
      role: :admin,
      password: 123456,
      password_confirmation: 123456
    })
    
    user.training_records.create({
      training_video_id: video.id
    })
    
    t = TrainingRecord.count
    user.destroy
    
    assert TrainingRecord.count == t-1
  end
end
