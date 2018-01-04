require 'test_helper'

class TimecardsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  # --- Things that should work
    # --- Deputy tests
      # Index all timecards
      test "deputy index" do
        sign_in users(:deputy)
        get timecards_path
        assert_response :success
      end
      
      # new timecard path
      test "deputy new" do
        sign_in users(:deputy)
        get new_timecard_path
        assert_response :success
      end
      
      # create timecard
      test "deputy create" do
        sign_in users(:deputy)
        
        assert_difference('Timecard.count', 1) do
          post timecards_path, params: {timecard: valid_timecard_params}
        end
        assert flash[:success]
      end 
      
      # show timecard
      test "deputy show" do
        sign_in users(:deputy)
        get timecard_path(timecards(:deputy))
        assert_response :success
      end    
      
      # edit timecard
      test "deputy edit" do
        sign_in users(:deputy)
        get edit_timecard_path(timecards(:deputy))
        
        assert_response :success
      end     
      
      # update timecard
      test "deputy update" do
        sign_in users(:deputy)
        patch timecard_path(timecards(:deputy)), params: {timecard: {description: "new description"}}
        
        assert flash[:success]
        assert_response :redirect
      end     
      
      # destroy timecard
      test "deputy destroy" do
        sign_in users(:deputy)
        
        assert_difference('Timecard.count', -1) do
          delete timecard_path(timecards(:deputy))
        end
        assert flash[:success]
        assert_response :redirect
      end      
      
    # --- Trainer tests
      # admindex
      test "trainer admindex" do
        sign_in users(:trainer)
        get admin_timecards_path
        
        assert_response :success
      end
      
      # show someone else's timecard
      test "trainer show" do
        sign_in users(:trainer)
        get timecard_path(timecards(:deputy))
        
        assert_response :success
      end
      
    # --- Admin tests
      # destroy someone else's timecard
      test "admin delete" do
        sign_in users(:admin)
        
        assert_difference('Timecard.count', -1) do
          delete timecard_path(timecards(:deputy))
        end
        assert flash[:success]
        assert_response :redirect
      end
  
  # --- Things that shouldn't work
    # --- Pending tests
    
    # --- Deputy tests
      # admindex
      
    
    # --- Trainer tests
      # delete someone else's
      
    # --- Admin tests  
      # create someone else's
      
      # edit someone else's 
      

end
