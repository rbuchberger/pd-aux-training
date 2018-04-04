module DocumentsHelper
  def page_controls(documents)
    if documents.total_pages > 1
      is_first = documents.page == 1
      is_last  = documents.page == documents.total_pages
      last_page_params = { query: documents.query, sort_by: documents.sort_by, page: documents.page - 1 }
      next_page_params = { query: documents.query, sort_by: documents.sort_by, page: documents.page + 1 }
      render partial: 'pager', locals: {
        is_first: is_first,
        is_last: is_last,
        last_page_params: last_page_params,
        next_page_params: next_page_params,
        current_page: documents.page,
        total_pages: documents.total_pages
      }
    end
  end
end
