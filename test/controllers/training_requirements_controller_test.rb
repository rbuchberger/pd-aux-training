require 'test_helper'

class TrainingRequirementsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  # --- Things that should work
    # --- Deputy tests
      # show action
      test "deputy show" do
        sign_in users(:deputy)
        get training_requirements_path(training_requirements(:one))
        
        assert_response :success
      end
      
      # index action
      test "deputy index" do
        sign_in users(:deputy)
        get training_requirements_path
        
        assert_response :success
      end
      
    # --- Trainer tests
      # new action
      test "trainer new" do
        sign_in users(:trainer)
        get new_training_requirement_path
        
        assert_response :success
      end
      
      # create action
      test "trainer create" do
        sign_in users(:trainer)
        assert_difference('TrainingRequirement.count') do
          post training_requirements_path, params: {training_requirement: valid_training_requirement_params}
        end
        
        assert flash[:success]
        assert_response :redirect
      end
      # update action
      test "trainer update" do
        sign_in users(:trainer)
        patch training_requirement_path(training_requirements(:one)),  params: {training_requirement: {description: "new description"}}
        t = TrainingRequirement.find(training_requirements(:one).id)
        assert_equal t.description, "new description"
        assert flash[:success]
        assert_response :redirect
      end      
      # destroy action
      test "trainer destroy" do
        sign_in users(:trainer)
        assert_difference('TrainingRequirement.count') do
          post training_requirements_path, params: {training_requirement: valid_training_requirement_params}
        end
        
        assert flash[:success]
        assert_response :redirect
      end      
      
      # user index by video action
      test "trainer users list" do
        sign_in users(:trainer)
        get users_training_requirement_path(training_requirements(:one))
        
        assert_response :success
      end

  # --- Things that shouldn't work
    # --- Deputy tests
      # new action
      test "deputy new" do
        sign_in users(:deputy)
        get new_training_requirement_path
        
        assert flash[:alert]        
        assert_redirected_to root_path
      end
      
      # create action
      test "deputy create" do
        sign_in users(:deputy)
        assert_no_difference('TrainingRequirement.count') do
          post training_requirements_path, params: {training_requirement: valid_training_requirement_params}
        end
        
        assert flash[:alert]
        assert_redirected_to root_path
      end
      # update action
      test "deputy update" do
        sign_in users(:deputy)
        patch training_requirement_path(training_requirements(:one)),  params: {description: "new description"}
        t = TrainingRequirement.find(training_requirements(:one).id)
        assert t.description != "new description"
        assert flash[:alert]
        assert_redirected_to root_path
      end      
      # destroy action
      test "deputy destroy" do
        sign_in users(:deputy)
        assert_no_difference('TrainingRequirement.count') do
          delete training_requirement_path(training_requirements(:one))
        end
        
        assert flash[:alert]
        assert_redirected_to root_path
      end      
      
      # user index by video action
      test "deputy users list" do
        sign_in users(:deputy)
        get users_training_requirement_path(training_requirements(:one))
        
        assert flash[:alert]        
        assert_redirected_to root_path
      end
    # --- Logged out test
      # Index action
      test "logged out index" do
        get training_requirements_path
        
        assert flash[:alert]        
        assert_redirected_to new_user_session_path
      end
  
end
