require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  # URL is a valid youtube video
  test 'Bad URL' do
    t = Lesson.new(valid_lesson_params)
    t.video.url = 'asdf'
    assert_not t.save
  end

  # Grabs youtube ID before save which matches the correct pattern

  test 'grabs yt_id' do
    t = Lesson.create(valid_lesson_params)
    assert t.video.yt_id == 'PdDu9T1EbWM'
  end
end
