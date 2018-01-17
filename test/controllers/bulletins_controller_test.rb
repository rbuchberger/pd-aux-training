require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

    # Trainer New
    test "trainer new" do
    sign_in users(:trainer)
    get new_bulletin_path

    assert_response :success
    end

    # Trainer Create
    test "trainer create" do
      sign_in users(:trainer)
      
      assert_difference('Bulletin.count') do
        post bulletins_path(bulletins(:two)), params: {bulletin: valid_bulletin_params }
      end
      assert flash[:success]
      assert_response :redirect
    end
    # Trainer Edit
    test "trainer edit" do
      sign_in users(:trainer)
      get edit_bulletin_path(bulletins(:two))

      assert_response :success
    end

    # Trainer Update
    test "trainer update" do
      sign_in users(:trainer)
      t = bulletins(:two)
      patch bulletin_path(t), params: {bulletin: {body: "I have a new body!" }}
      assert_equal Bulletin.find(t.id).body, "I have a new body!"
      assert flash[:success]
      assert_response :redirect
    end
    # Trainer Destroy
    test "trainer destroy" do
      sign_in users(:trainer)
      t = Bulletin.create(valid_bulletin_params)
      assert_difference('Bulletin.count', -1) do
        delete bulletin_path(t.id)
      end
      assert flash[:success]
      assert_response :redirect
    end

end
