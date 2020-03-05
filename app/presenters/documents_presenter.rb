module DocumentsPresenter
  class ProcessedDocuments
    include ActiveRecord::Sanitization::ClassMethods
    # This is a class designed to handle document library presentation. It
    # stands between the model and controller; it sorts, pageinates, and
    # searches documents to make the index page more manageable and useful. This
    # logic doesn't belong in the controller, or the model, so it gets its own
    # class.

    # List is the list of documents, page is the current page number, total
    # pages is the total number of pages.
    attr_reader :list, :page, :total_pages, :sort_by, :query, :params

    def initialize(params = {})
      # Params can include sort_by, query, and page. If not specified, default
      # values are assumed.

      @query = params[:query]

      @sort_by = params[:sort_by]
      @sort_by = sort_default if @sort_by.blank?

      @page = params[:page].blank? ? 1 : params[:page].to_i
      @per_page = 30
      @offset = (@page - 1) * @per_page

      # For the pager
      @params = { sort_by: @sort_by, query: @query }

      build_list
    end

    # .order() is vulnerable to SQL injection, so I'm abstracting its argument
    # from the form with this hash:
    def sort_options
      {
        'Newest' => 'file_updated_at DESC',
        'Oldest' => 'file_updated_at ASC',
        'Alphabetic' => 'name'
      }
    end

    def sort_default
      'Newest'
    end

    private

    def build_list
      sort_by_sql = sort_options[@sort_by]
      if @query.blank?
        @list = Document.order(sort_by_sql).limit(@per_page).offset(@offset)
        @total_pages = (Document.count.to_f / @per_page).ceil
      else
        query_sql = "%#{sanitize_sql_like(@query)}%"
        query_arg = "file_file_name LIKE :query OR
                     name LIKE :query OR
                     description LIKE :query"
        @list = Document.where(query_arg, { query: query_sql }).order(sort_by_sql).limit(@per_page).offset(@offset)
        @total_pages = (Document.where(query_arg, { query: query_sql }).count / @per_page).ceil
      end
    end
  end
end
