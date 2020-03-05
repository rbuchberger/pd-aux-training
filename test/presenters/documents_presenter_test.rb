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
    assert_equal 1, @t.total_pages
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
    assert_equal @t.query, 'One'
  end

  # return "sorting value (for the form)
  test 'sort value' do
    assert_equal @t.sort_by, 'Alphabetic'
  end

  # return page number (for the form)
  test 'Page' do
    assert_equal @t.page, 1
  end

  # return the proper list
  test 'list' do
    # Only one fixture with the name "One"
    assert_equal @t.list.length, 1
    assert_equal @t.list.first.name, 'Test file One'
  end

  # return it in the correct order
  test 'alphabetic sort' do
    t = ProcessedDocuments.new({ sort_by: 'Alphabetic' })

    assert_equal t.list.first.id,
                 Document.all.order(:name).first.id
  end
  test 'oldest sort' do
    t = ProcessedDocuments.new({ sort_by: 'Oldest' })

    assert_equal t.list.first.id,
                 Document.all.order(file_updated_at: :asc).first.id
  end
  test 'newest sort' do
    t = ProcessedDocuments.new({ sort_by: 'Newest' })

    assert_equal t.list.first.id,
                 Document.all.order(file_updated_at: :desc).first.id
  end
end
