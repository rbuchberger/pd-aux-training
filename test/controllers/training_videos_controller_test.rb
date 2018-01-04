require 'test_helper'

class TrainingVideosControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  # --- Things that should work
    # --- Deputy tests
      # show action
      test "deputy show" do
        sign_in users(:deputy)
        get training_video_path(training_videos(:one))
        
        assert_response :success
      end
      
      # index action
      test "deputy index" do
        sign_in users(:deputy)
        get training_videos_path
        
        assert_response :success
      end
      
    # --- Trainer tests
      # new action
      test "trainer new" do
        sign_in users(:trainer)
        get new_training_video_path
        
        assert_response :success
      end
      
      # create action
      test "trainer create" do
        sign_in users(:trainer)
        assert_difference('TrainingVideo.count') do
          post training_videos_path, params: {training_video: valid_video_params}
        end
        
        assert flash[:success]
        assert_response :redirect
      end
      # update action
      test "trainer update" do
        sign_in users(:trainer)
        patch training_video_path(training_videos(:one)),  params: {training_video: {description: "new description"}}
        t = TrainingVideo.find(training_videos(:one).id)
        assert_equal t.description, "new description"
        assert flash[:success]
        assert_response :redirect
      end      
      # destroy action
      test "trainer destroy" do
        sign_in users(:trainer)
        assert_difference('TrainingVideo.count') do
          post training_videos_path, params: {training_video: valid_video_params}
        end
        
        assert flash[:success]
        assert_response :redirect
      end      
      
      # user index by video action
      test "trainer users list" do
        sign_in users(:trainer)
        get users_training_video_path(training_videos(:one))
        
        assert_response :success
      end

  # --- Things that shouldn't work
    # --- Deputy tests
      # new action
      test "deputy new" do
        sign_in users(:deputy)
        get new_training_video_path
        
        assert flash[:alert]        
        assert_redirected_to root_path
      end
      
      # create action
      test "deputy create" do
        sign_in users(:deputy)
        assert_no_difference('TrainingVideo.count') do
          post training_videos_path, params: {training_video: valid_video_params}
        end
        
        assert flash[:alert]
        assert_redirected_to root_path
      end
      # update action
      test "deputy update" do
        sign_in users(:deputy)
        patch training_video_path(training_videos(:one)),  params: {description: "new description"}
        
        assert training_videos(:one).description != "new description"
        assert flash[:alert]
        assert_redirected_to root_path
      end      
      # destroy action
      test "deputy destroy" do
        sign_in users(:deputy)
        assert_no_difference('TrainingVideo.count') do
          delete training_video_path(training_videos(:one))
        end
        
        assert flash[:alert]
        assert_redirected_to root_path
      end      
      
      # user index by video action
      test "deputy users list" do
        sign_in users(:deputy)
        get users_training_video_path(training_videos(:one))
        
        assert flash[:alert]        
        assert_redirected_to root_path
      end
    # --- Logged out test
      # Index action
      test "logged out index" do
        get training_videos_path
        
        assert flash[:alert]        
        assert_redirected_to new_user_session_path
      end
  
end
