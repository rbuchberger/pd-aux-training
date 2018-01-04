require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  # --- Logged out user tests 
  
  test "home" do
    get root_path
    assert_response :success
  end
  
  # --- Trainer & Admin tests
  
  test "home-trainer" do
    sign_in users(:trainer)
    get root_path
    
    assert_response :success
  end
  
  # --- Deputy tests
  test "home-deputy" do
    sign_in users(:deputy)
    get root_path
    
    assert_response :success
  end
    
end
