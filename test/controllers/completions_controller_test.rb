require 'test_helper'

class CompletionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  # --- Things that should work
    # --- Deputy tests
      # Create completion
      test "deputy create own" do
        sign_in users(:deputy)
        assert_difference('users(:deputy).completions.count') do
          post completions_lesson_path(lessons(:four)) 
        end
        assert flash[:success]
        assert_response :redirect
      
      end
      
      # delete completion
      test "deputy delete own" do
        sign_in users(:deputy)
        
        assert_difference('users(:deputy).completions.count', -1) do
          delete completion_path(completions(:deputy))
        end
        
        assert flash[:success]
        assert_response :redirect
      end      
      
    # --- Trainer tests
      # Completion index
      test "trainer index" do
        sign_in users(:trainer)
        
        get completions_path
        
        assert_response :success
      end

  # --- Things that shouldn't work

    # --- Deputy tests
      # Completion index
      test "deputy index" do
        sign_in users(:deputy)
        
        get completions_path
        
        assert flash[:alert]
        assert_redirected_to root_path
      end

    # --- Admin tests  
      # delete someone else's record
      test "admin delete else" do
        sign_in users(:admin)
        
        assert_no_difference('users(:deputy).completions.count') do
          delete completion_path(completions(:deputy))
        end
        
        assert flash[:alert]
        assert_redirected_to root_path
      end      

end
