require 'test_helper'

class TrainingVideoTest < ActiveSupport::TestCase

  # URL is a valid youtube video
  test "Bad URL" do
    t = TrainingRequirement.new(valid_training_requirement_params)
    t.training_video.url = "asdf"
    assert_not t.save
  end
  
  # Grabs youtube ID before save which matches the correct pattern

  test "grabs yt_id" do
    t = TrainingRequirement.create(valid_training_video_params) 
    assert t.training_video.yt_id == "PdDu9T1EbWM"
  end
  
end
