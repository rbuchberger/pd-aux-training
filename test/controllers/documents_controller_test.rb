require 'test_helper'

# Deputy tests
class DocumentsControllerDeputyTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:deputy)
  end

  # index
  test 'index' do
    # Skipping until ActiveStorage::FixtureSet hits main. Stubbing this properly is annoying.
    skip
    get documents_path

    assert_response :success
  end

  # new
  test 'new' do
    get new_document_path

    assert flash[:alert]
    assert_redirected_to root_path
  end

  # create as deputy
  test 'create' do
    assert_no_difference 'Document.count' do
      post documents_path, params: { document: valid_document_params }
    end

    assert flash[:alert]
    assert_redirected_to root_path
  end

  # edit
  test 'edit' do
    get edit_document_path(documents(:one))

    assert flash[:alert]
    assert_redirected_to root_path
  end

  # update as deputy
  test 'update' do
    t = documents(:one)

    patch document_path(documents(:one)),
          params: { document: { name: 'new name!' } }

    assert_equal t.name, Document.find(t.id).name
    assert flash[:alert]
    assert_redirected_to root_path
  end

  # destroy
  test 'destroy' do
    assert_no_difference 'Document.count' do
      delete document_path(documents(:one))
    end

    assert flash[:alert]
    assert_redirected_to root_path
  end
end

# Trainer tests
class DocumentsControllerTrainerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:trainer)
  end

  # new
  test 'new' do
    get new_document_path

    assert_response :success
  end

  # create
  test 'create' do
    assert_difference 'Document.count', 1 do
      post documents_path, params: { document: valid_document_params }
    end

    assert flash[:success]
  end

  # edit
  test 'edit' do
    get edit_document_path(documents(:one))

    assert_response :success
  end

  # update
  test 'update' do
    # Skipping until ActiveStorage::FixtureSet hits main. Stubbing this properly is annoying.
    skip
    t = documents(:one)

    patch document_path(documents(:one)), params: { document: { name: 'new name!' } }

    assert flash[:success]
    assert_equal 'new name!', Document.find(t.id).name
  end

  # destroy
  test 'destroy' do
    assert_difference 'Document.count', -1 do
      delete document_path(documents(:one))
    end

    assert flash[:success]
  end
end

# Not logged in tests
class DocumentsControllerGuestTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # index
  test 'index' do
    get documents_path

    assert_redirected_to new_user_session_path
    assert flash[:alert]
  end

  # show
  test 'show' do
    get document_path(documents(:one))

    assert_redirected_to new_user_session_path
    assert flash[:alert]
  end

  # new
  test 'new' do
    get new_document_path

    assert_redirected_to new_user_session_path
    assert flash[:alert]
  end

  # create
  test 'create' do
    assert_no_difference 'Document.count' do
      post documents_path, params: valid_document_params
    end

    assert_redirected_to new_user_session_path
    assert flash[:alert]
  end

  # edit
  test 'edit' do
    get edit_document_path(documents(:one))

    assert_redirected_to new_user_session_path
    assert flash[:alert]
  end

  # update
  test 'update' do
    t = documents(:one)

    patch document_path(documents(:one)), params: { name: 'new name!' }

    assert_equal t.name, Document.find(t.id).name
    assert_redirected_to new_user_session_path
    assert flash[:alert]
  end

  # destroy
  test 'destroy' do
    assert_no_difference 'Document.count' do
      delete document_path(documents(:one))
    end

    assert_redirected_to new_user_session_path
    assert flash[:alert]
  end
end
