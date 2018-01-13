require 'test_helper'

class TrainingRecordsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  # --- Things that should work
    # --- Deputy tests
      # Create training record
      test "deputy create own" do
        sign_in users(:deputy)
        assert_difference('users(:deputy).training_records.count') do
          post training_records_training_requirement_path(training_requirements(:four)) 
        end
        assert flash[:success]
        assert_response :redirect
      
      end
      
      # delete training record
      test "deputy delete own" do
        sign_in users(:deputy)
        
        assert_difference('users(:deputy).training_records.count', -1) do
          delete training_record_path(training_records(:deputy))
        end
        
        assert flash[:success]
        assert_response :redirect
      end      
      
    # --- Trainer tests
      # Training record index
      test "trainer index" do
        sign_in users(:trainer)
        
        get training_records_path
        
        assert_response :success
      end

  # --- Things that shouldn't work

    # --- Deputy tests
      # Training record index
      test "deputy index" do
        sign_in users(:deputy)
        
        get training_records_path
        
        assert flash[:alert]
        assert_redirected_to root_path
      end

    # --- Admin tests  
      # delete someone else's record
      test "admin delete else" do
        sign_in users(:admin)
        
        assert_no_difference('users(:deputy).training_records.count') do
          delete training_record_path(training_records(:deputy))
        end
        
        assert flash[:alert]
        assert_redirected_to root_path
      end      

end
