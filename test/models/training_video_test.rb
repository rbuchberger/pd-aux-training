require 'test_helper'

class TrainingVideoTest < ActiveSupport::TestCase

  # URL is a valid youtube video
  test "Bad URL" do
    t = TrainingVideo.new(valid_video_params)
    t.url = "asdf"
    assert_not t.save
  end
  
  # Grabs youtube ID before save which matches the correct pattern

  test "grabs yt_id" do
    t = TrainingVideo.create(valid_video_params) 
    assert t.yt_id == "PdDu9T1EbWM"
  end
  
end
