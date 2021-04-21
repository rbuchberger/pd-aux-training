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
    t = Document.new(valid_document_params.except(:file))
    assert_not t.valid?
    assert_not t.save
  end

  # Set name if filename is missing:
  test 'no_name' do
    p = valid_document_params
    p[:name] = ''

    t = Document.new(p)
    t.save

    assert_equal t.name, 'test.txt'
  end
end
