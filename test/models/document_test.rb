require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  # Successfully create a new one
  test 'create' do
    t = Document.new(valid_document_params)

    assert t.valid?
    assert t.save
  end

  # No file
  test 'no_file' do
    skip

    p = valid_document_params
    p[:file] = nil

    t = Document.new(p)
    assert_not t.valid?
    assert_not t.save
  end

  # Bad file type, bad extension
  test 'bad file' do
    skip

    p = valid_document_params
    p[:file] = fixture_file_upload('badfile.tar.gz', 'text/plain')

    t = Document.new(p)
    assert_not t.valid?
    assert_not t.save
  end

  # Bad file type, good extension
  test 'bad file type' do
    skip

    p = valid_document_params
    p[:file] = fixture_file_upload('badfile.txt', 'text/plain')

    t = Document.new(p)
    assert_not t.valid?
    assert_not t.save
  end

  # Good file type, bad extension
  test 'bad extension' do
    skip

    p = valid_document_params
    p[:file] = fixture_file_upload('badfile2.tar.gz', 'text/plain')

    t = Document.new(p)
    assert_not t.valid?
    assert_not t.save
  end

  # Set name if filename is missing:
  test 'no_name' do
    skip

    p = valid_document_params
    p[:name] = ''

    t = Document.new(p)
    t.save

    assert_equal t.name, 'test.txt'
  end
end
