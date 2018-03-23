require 'test_helper'

class LessonTest < ActiveSupport::TestCase
  # Shouldn't save without a title
  test "no title" do
    t = Lesson.new(valid_lesson_params)
    t.title = ""
    
    assert_not t.save
  end
  # Title can't be longer than 50 characters
  test "long title" do
    t = Lesson.new(valid_lesson_params)
    t.title = "c" * 51
    
    assert_not t.save
  end
  # Description can't be longer than 1000 characters
  test "long description" do
    t = Lesson.new(valid_lesson_params)
    t.description = "I" * 1001
  
    assert_not t.save
  end

end
