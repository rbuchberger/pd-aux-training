require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  # --- Things that should work
    # --- Deputy tests
      # Show
      test "deputy show" do
        sign_in users(:deputy)
        get user_path(users(:deputy))
        
        assert_response :success
      end
      
      # Training Videos
      test "deputy training_videos" do
        sign_in users(:deputy)
        get training_videos_user_path(users(:deputy))
        
        assert_response :success
      end
      
    # --- Trainer tests
      # index
      test "trainer index" do
        sign_in users(:trainer)
        get users_path
        
        assert_response :success
      end
      
      # approve
      test "trainer approve" do
        sign_in users(:trainer)
        put accept_user_path(users(:pending))
        t = User.find(users(:pending).id)
        
        assert_response :redirect
        assert flash[:success]
        assert_equal t.role, "deputy"
      end
      
      # reject
      test "trainer reject" do
        sign_in users(:trainer)
        assert_difference('User.count', -1) do
          delete reject_user_path(users(:pending))
        end
        assert_response :redirect
        assert flash[:success]
      end
      
      # someone else's training videos
      test "trainer user videos" do
        sign_in users(:trainer)
        get training_videos_user_path(users(:deputy))
        
        assert_response :success
      end
      
    # --- Admin tests
      # edit
      test "admin edit user" do
        sign_in users(:admin)
        get edit_user_path(users(:deputy))
        
        assert_response :success
      end
      # update
      test "admin update user" do
        sign_in users(:admin)
        test_user = users(:deputy)
        patch user_path(test_user), params: {user: {first_name: "newname"}}
        t = User.find(test_user.id)
        
        assert_equal t.first_name, "Newname"
        assert_response :redirect
        assert flash[:success]
      end
      
      # destroy
      test "admin delete" do
        sign_in users(:admin)
        
        assert_difference('User.count', -1) do
          delete user_path(users(:deputy))
        end
        assert_response :redirect
        assert flash[:success]
      end
  
  # --- Things that shouldn't work
  
    # --- Logged out test
    
    # --- Deputy tests
      # index
    
      # approve
      
      # reject
      
      # Someone else's training videos
    # --- Trainer tests
      # update
      
      # edit
      
      # destroy
    
    # --- Admin tests  
end
