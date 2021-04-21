require 'test_helper'

# Default values:
class DocumentsPresenterDefaults < ActionDispatch::IntegrationTest
  include DocumentsPresenter

  setup do
    @t = ProcessedDocuments.new
  end

  test 'page' do
    assert_equal 1, @t.page
  end

  test 'total_pages' do
    assert_equal 1, @t.page_count
  end

  test 'sort_by' do
    assert_equal 'Newest', @t.sort_by
  end

  test 'query' do
    assert_nil @t.query
  end

  test 'list' do
    c = Document.count
    c = 30 if c > 30
    assert_equal c, @t.list.length
  end

  # Sort options
  test 'sort options' do
    assert_not_nil @t.sort_options
  end
end

# Queries and values
class DocumentsPresenterQueries < ActionDispatch::IntegrationTest
  include DocumentsPresenter

  setup do
    p = {
      query: 'One',
      sort_by: 'Alphabetic',
      page: '1'
    }

    @t = ProcessedDocuments.new(p)
  end

  # return query (for the form)
  test 'query' do
    assert_equal 'One', @t.query
  end

  # return "sorting value (for the form)
  test 'sort value' do
    assert_equal 'Alphabetic', @t.sort_by
  end

  # return page number (for the form)
  test 'Page' do
    assert_equal 1, @t.page
  end

  test 'list' do
    # Fails because we don't have blob fixtures yet. Fix when
    # ActiveStorage::FixtureSet is released.
    skip

    # Only one fixture with the name "One"
    assert_equal 1, @t.list.length
    assert_equal 'Test file One', @t.list.first.name
  end

  # return it in the correct order
  test 'alphabetic sort' do
    t = ProcessedDocuments.new({ sort_by: 'Alphabetic' })

    assert_equal Document.all.order(:name).first.id, t.list.first.id
  end
  test 'oldest sort' do
    t = ProcessedDocuments.new({ sort_by: 'Oldest' })

    assert_equal Document.all.order(file_updated_at: :asc).first.id, t.list.first.id
  end
  test 'newest sort' do
    t = ProcessedDocuments.new({ sort_by: 'Newest' })

    assert_equal Document.all.order(file_updated_at: :desc).first.id, t.list.first.id
  end
end
