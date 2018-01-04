require 'test_helper'

class TrainingVideoTest < ActiveSupport::TestCase
  # Shouldn't save without a title
  test "no title" do
    t = TrainingVideo.new(valid_video_params)
    t.title = ""
    
    assert_not t.save
  end
  # Title can't be longer than 50 characters
  test "long title" do
    t = TrainingVideo.new(valid_video_params)
    t.title = "c" * 51
    
    assert_not t.save
  end
  # Description can't be longer than 1000 characters
  test "long description" do
    t = TrainingVideo.new(valid_video_params)
    t.description = "I" * 1001
  
    assert_not t.save
  end
  # URL is a valid youtube video
  test "Bad URL" do
    t = TrainingVideo.new(valid_video_params)
    t.url = "asdf"
    assert_not t.save
  end
  
  # Grabs youtube ID before save which matches the correct pattern
  # Yeah, I know this isn't a very good test. 
  test "grabs yt_id" do
    t = TrainingVideo.create(valid_video_params) 
    assert t.yt_id == "PdDu9T1EbWM"
  end
  
end
