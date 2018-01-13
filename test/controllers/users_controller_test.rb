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
      test "deputy training_requirements" do
        sign_in users(:deputy)
        get training_requirements_user_path(users(:deputy))
        
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
        patch approve_user_path(users(:pending))
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
      
      # someone else's training requirements 
      test "trainer user requirements" do
        sign_in users(:trainer)
        get training_requirements_user_path(users(:deputy))
        
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

      # Activate
      test "admin activate" do
        sign_in users(:admin) 
        patch reactivate_user_path(users(:deactivated))

        assert_not User.unscoped.find(users(:deactivated).id).deleted_at
      end 
  
      # Deactivate
      test "admin deactivate" do 
        sign_in users(:admin)
        patch deactivate_user_path(users(:trainer))
        t = User.unscoped.find(users(:trainer).id)

        assert t.deleted_at > (Time.zone.now - 10.seconds) 
        assert_equal t.role, "deputy"
      end
  # --- Things that shouldn't work
  
    # --- Logged out test
      test "logged out index" do
        get users_path
        
        assert_redirected_to new_user_session_path
        assert flash[:alert]
      end
      
    # --- Deputy tests
      # index
      test "deputy index" do
        sign_in users(:deputy)
        get users_path
        
        assert_redirected_to root_path
        assert flash[:alert]
        
      end
      # approve
      
      test "deputy approve" do
        sign_in users(:deputy)
        patch approve_user_path(users(:pending))
        t = User.unscoped.find(users(:pending).id)
        
        assert_redirected_to root_path
        assert flash[:alert]
        assert_equal t.role, "pending"        
      end
      
      # reject
      test "deputy reject" do
        sign_in users(:deputy)
        assert_no_difference('User.count') do
          delete reject_user_path(users(:pending))
        end
        assert_redirected_to root_path
        assert flash[:alert]
      end      
      
      # Someone else's training requirements 
      test "deputy user requirements" do
        sign_in users(:deputy)
        get training_requirements_user_path(users(:trainer))
        
        assert_redirected_to root_path
        assert flash[:alert]
      end
      
    # --- Trainer tests
      # edit
      test "trainer edit user" do
        sign_in users(:trainer)
        get edit_user_path(users(:deputy))
        
        assert_redirected_to root_path
        assert flash[:alert]
      end
      # update
      test "trainer update user" do
        sign_in users(:trainer)
        test_user = users(:deputy)
        patch user_path(test_user), params: {user: {first_name: "newname"}}
        t = User.find(test_user.id)
        
        assert_equal t.first_name, users(:deputy).first_name
        assert_redirected_to root_path
        assert flash[:alert]
      end
      
      # destroy
      test "trainer delete" do
        sign_in users(:trainer)
        
        assert_no_difference('User.count') do
          delete user_path(users(:deputy))
        end
        assert_redirected_to root_path
        assert flash[:alert]
      end
      
      # reject non-pending user
      test "trainer reject nonpending" do
        sign_in users(:trainer)

        assert_no_difference('User.count') do
          delete reject_user_path(users(:deputy))
        end
        assert_redirected_to root_path
        assert flash[:alert]        
      end
      
      # Deactivate user
      test "trainer deactivate" do
        sign_in users(:trainer)
        patch deactivate_user_path(users(:deputy))

        assert_not User.find(users(:deputy).id).deleted_at
        assert_redirected_to root_path
        assert flash[:alert]
      end

      # Reactivate user
      test "trainer reactivate" do 
        sign_in users(:trainer)
        patch reactivate_user_path(users(:deputy))

        assert_nil User.find(users(:deputy).id).deleted_at
        assert flash[:alert]
        assert_redirected_to root_path
      end
        
    # --- Admin tests
      # Reject pending user with records (Can only happen if user is manually set back to
      # pending and then deleted.) 
      test "admin reject pending with records" do
        u = users(:deputy)
        u.role = :pending
        u.save

        assert_no_difference('User.count') do
          delete reject_user_path(u)
        end
        assert flash[:alert]
      end
 
end
