require 'test_helper'

class CompletionTest < ActiveSupport::TestCase
  
  # Shouldn't save without a user
  test "save without user" do
    t = Completion.new(valid_completion_params)
    t.user_id = ""
    assert_not t.save
  end
  
  # Shouldn't save without a lesson
  test "save without lesson" do
    t = Completion.new(valid_completion_params)
    t.lesson_id = ""
    
    assert_not t.save
  end
  
  # Should be deleted when associated lesson is deleted
  test "delete with lesson" do
    lesson = lessons(:one)
    user = users(:admin)
    user.completions.create({
      lesson_id: lesson.id
    })
    
    t = Completion.count 
    lesson.destroy
    assert t > Completion.count
    
  end
  
  # Should be deleted when associated user is deleted
  test "delete with user" do
    lesson = lessons(:one)
    user = users(:admin)
    user.completions.create({
      lesson_id: lesson.id
    })
    
    t = Completion.count 
    user.destroy
    assert t > Completion.count
    
  end
end
