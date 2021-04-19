# Handles arguments and logic for the document page controls
class DocumentPager
  def initialize(documents)
    @documents = documents
  end

  def locals
    {
      is_first: first?,
      is_last: last?,
      last_page_params: last_page_params,
      next_page_params: next_page_params,
      current_page: documents.page,
      total_pages: documents.page_count
    }
  end

  private

  attr_reader :documents

  def last_page_params
    {
      query: documents.query,
      sort_by: documents.sort_by,
      page: documents.page - 1
    }
  end

  def next_page_params
    {
      query: documents.query,
      sort_by: documents.sort_by,
      page: documents.page + 1
    }
  end

  def first?
    documents.page == 1
  end

  def last?
    documents.page == documents.page_count
  end
end
