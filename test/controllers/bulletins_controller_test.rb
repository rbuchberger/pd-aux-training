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

    # Things that shouldn't work:
    # Deputy New
    test "deputy new" do
    sign_in users(:deputy)
    get new_bulletin_path

    assert flash[:alert]
    end

    # Deputy Create
    test "deputy create" do
      sign_in users(:deputy)
      
      assert_no_difference('Bulletin.count') do
        post bulletins_path(bulletins(:two)), params: {bulletin: valid_bulletin_params }
      end
      assert flash[:alert]
      assert_response :redirect
    end
    # Deputy Edit
    test "Deputy edit" do
      sign_in users(:deputy)
      get edit_bulletin_path(bulletins(:two))

      assert flash[:alert]
      assert_response :redirect
    end

    # deputy Update
    test "deputy update" do
      sign_in users(:deputy)
      t = bulletins(:two)
      td = t.body
      patch bulletin_path(t), params: {bulletin: {body: "I have a new body!" }}

      assert_equal Bulletin.find(t.id).body, td
      assert flash[:alert]
      assert_response :redirect
    end
    # Deputy Destroy
    test "deputy destroy" do
      sign_in users(:deputy)
      t = Bulletin.create(valid_bulletin_params)
      assert_no_difference('Bulletin.count') do
        delete bulletin_path(t.id)
      end
      
      assert_response :redirect
      assert flash[:alert]
    end
end
