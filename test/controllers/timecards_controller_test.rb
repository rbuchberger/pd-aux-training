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
        t = timecards(:deputy)
        patch timecard_path(t), params: {timecard: {'description' => 'new description'}}
        t = Timecard.find(t.id)

        assert_equal  'new description', t.description
        assert flash[:success]
        assert_redirected_to timecard_path(t)
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
    # --- Not logged in tests
      # Logged out users should be redirected
      test "logged out index" do
        get timecards_path
        
        assert_redirected_to new_user_session_path
        assert flash[:alert]
      end
      
    # --- Deputy tests
      # Deputies accessing admindex should throw an error
      test "deputy admindex" do
        sign_in users(:deputy)
        get admin_timecards_path
        
        assert_redirected_to root_path
        assert flash[:alert]
      end
      
      # Deputies editing someone else's timecard should throw an error
      test "deputy update someone else" do
        sign_in users(:deputy)
        t = timecards(:trainer)
        patch timecard_path(t), params: {timecard: {'description' => 'new description'}}
        t = Timecard.find(t.id)
    
        assert_redirected_to root_path
        assert flash[:alert]
        assert timecards(:trainer).description == t.description
      end
    
    # --- Trainer tests
      # delete someone else's
      test "trainer delete someone else" do
        sign_in users(:trainer)
        assert_no_difference('Timecard.count') do
          delete timecard_path(timecards(:deputy))
        end
        
        assert_redirected_to root_path
        assert flash[:alert]
        assert timecards(:deputy)
      end
      
    # --- Admin tests  

      # edit someone else's 
      test "admin update someone else" do
        sign_in users(:admin)
        t = timecards(:trainer)
        patch timecard_path(t), params: {timecard: {'description' => 'new description'}}
        t = Timecard.find(t.id)
    
        assert_redirected_to root_path
        assert flash[:alert]
        assert_equal timecards(:trainer).description, t.description
      end

end
