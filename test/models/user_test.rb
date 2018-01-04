require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # I'm not gonna test all the functions of devise. Presumably the devise team
  # tests their software, I'll test the parts I touch. 
  
  # Should have a first name
  test "has first name" do
    t = User.new(valid_user_params)
    t.first_name = ""
    
    assert_not t.save
  end
  
  # First name no longer than 50 chars
  test "long first name" do
    t = User.new(valid_user_params)
    t.first_name = "a" * 51
    
    assert_not t.save
  end
  
  # Should have a last name
  test "has last name" do
    t = User.new(valid_user_params)
    t.last_name = ""
    
    assert_not t.save
  end  
  
  # Last name no longer than 50 chars
  test "long last name" do
    t = User.new(valid_user_params)
    t.last_name = "a" * 51
    
    assert_not t.save
  end 
  
  # Should have a badge number
  test "has badge number" do
    t = User.new(valid_user_params)
    t.badge_number = ""
    
    assert_not t.save
  end  
  
  # Badge number no longer than 4 chars
  test "long badge number" do
    t = User.new(valid_user_params)
    t.badge_number = "12345"
    
    assert_not t.save
  end 
  
  # Should capitalize string fields before save
  test "format strings" do
    t = User.new(valid_user_params)
    t.first_name = "asdf"
    t.last_name = "ASDF"
    t.badge_number = "abC2"
    
    t.save
    
    assert t.first_name = "Asdf"
    assert t.last_name = "Asdf"
    assert t.badge_number = "ABC2"
  end
  
  # Newly created users should be set to pending
  test "pending new" do
    t = User.new(valid_user_params)
    t.role = :admin
    t.save
    
    assert t.role = :pending
  end
  
  # pending users should not be considered active for authentication
  test "pending active" do
    t = User.create(valid_user_params)
    
    assert_not t.active_for_authentication?
  end
  
  # first_last(length) custom method
  test "first last" do
    t = users(:admin)
    
    assert t.first_last == "Austin Powers"
  end
  
  # last_first(length) custom method
  test "last, first" do
    t = users(:admin)
    
    assert t.last_first == "Powers, Austin"
  end
  
  # admins should be trainers too
  test "admins are trainers" do
    t = users(:admin)
    
    assert t.trainer?
  end
  
end
