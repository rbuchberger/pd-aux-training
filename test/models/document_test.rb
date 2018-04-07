require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  #This model relies heavily on paperclip. I'll test my logic, but I won't be
  #heavily testing core paperclip features, or core rails functionality. I'll
  #also save S3 calls for system tests rather than putting them here. 

  # I don't want to stub s3 responses globally in the test environment, because I'd like to use real s3 requests
  setup do
    stub_aws
  end

  teardown do
    unstub_aws
  end

  # Successfully create a new one 
  test "create" do
    t = Document.new(valid_document_params)

    assert t.valid?
    assert t.save
  end

  # No file
  test "no_file" do
    p = valid_document_params
    p[:file] = nil

    t = Document.new(p)
    assert_not t.valid?
    assert_not t.save
  end

  # Bad file type, bad extension
  test "bad file" do
    p = valid_document_params
    p[:file] = fixture_file_upload('files/badfile.tar.gz', 'text/plain')

    t = Document.new(p)
    assert_not t.valid?
    assert_not t.save
  end

  # Bad file type, good extension
  test "bad file type" do
    p = valid_document_params
    p[:file] = fixture_file_upload('files/badfile.txt', 'text/plain')

    t = Document.new(p)
    assert_not t.valid?
    assert_not t.save
  end

  # Good file type, bad extension
  test "bad extension" do
    p = valid_document_params
    p[:file] = fixture_file_upload('files/badfile2.tar.gz', 'text/plain')

    t = Document.new(p)
    assert_not t.valid?
    assert_not t.save
  end

  # Set name if filename is missing: 
  test "no_name" do
    p = valid_document_params
    p[:name] = ""

    t = Document.new(p)
    t.save

    assert_equal t.name, "test.txt"
  end

end
