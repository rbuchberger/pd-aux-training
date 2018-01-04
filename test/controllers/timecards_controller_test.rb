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
      # test "deputy create" do
      #   sign_in users(:deputy)
        
      #   assert_difference('Timecard.count', 1) do
      #     post timecards_path, params: valid_timecard_params
      #   end
      #   assert flash[:success]
        
      # end 
      
      # show timecard
      test "deputy show" do
        sign_in users(:deputy)
        
      end    
      
      # edit timecard
      test "deputy edit" do
        sign_in users(:deputy)
        
      end     
      
      # update timecard
      test "deputy update" do
        sign_in users(:deputy)
        
      end     
      
      # destroy timecard
      test "deputy destroy" do
        sign_in users(:deputy)
        
      end      
      
    # --- Trainer tests
      # admindex
      
      # show someone else's timecard
      
    # --- Admin tests
      # destroy someone else's timecard
      
  
  # --- Things that shouldn't work
    # --- Deputy tests
      # admindex
      
    
    # --- Trainer tests
      # delete someone else's
      
    # --- Admin tests  
      # create someone else's
      
      # edit someone else's 
      

end
