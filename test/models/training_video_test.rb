require 'test_helper'

class TrainingVideoTest < ActiveSupport::TestCase
  # Shouldn't save without a title
  test "no title" do
    t = TrainingVideo.new({
    # title: "How to apply handcuffs", 
    description: "I know someone who's into this stuff.", 
    url: "https://www.youtube.com/watch?v=PdDu9T1EbWM", 
  })
  
    assert_not t.save
  end
  # Title can't be longer than 50 characters
  test "long title" do
    t = TrainingVideo.new({
    title: "c" * 51, 
    description: "I know someone who's into this stuff.", 
    url: "https://www.youtube.com/watch?v=PdDu9T1EbWM", 
  })
  
    assert_not t.save
  end
  # Description can't be longer than 1000 characters
  test "long description" do
    t = TrainingVideo.new({
    title: "How to apply handcuffs", 
    description: "I" * 1001, 
    url: "https://www.youtube.com/watch?v=PdDu9T1EbWM", 
  })
  
    assert_not t.save
  end
  # URL is a valid youtube video
    test "Bad URL" do
    t = TrainingVideo.new({
    title: "How to apply handcuffs", 
    description: "I know someone who's into this stuff.", 
    url: "asdf", 
  })
  
    assert_not t.save
  end
  
  # Grabs youtube ID before save which matches the correct pattern
  # Yeah, I know this isn't a very good test. 
  test "grabs yt_id" do
    t = TrainingVideo.create({
    title: "How to apply handcuffs", 
    description: "I know someone who's into this stuff.", 
    url: "https://www.youtube.com/watch?v=PdDu9T1EbWM", 
    })
  
    assert t.yt_id == "PdDu9T1EbWM"
  end
  
end
