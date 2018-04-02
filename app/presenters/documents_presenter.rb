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
    attr_reader :list, :page, :total_pages, :sort_by

    def initialize(params)

      # per_page is the number of documents to display per page; it's hard-coded
      # to 30 for now but I may decide to make this user-selectable in the
      # future.

      if params[:query].blank?
        @query = false
      else
        @query = "%#{sanitize_sql_like(params[:query])}%"
      end

      @page    = params[:page].blank?    ?  1             : params[:page].to_i

      @per_page = 30
      @offset = ( @page - 1 ) * @per_page

      if params[:sort_by].blank?
        @sort_by = sort_options["Newest"]
      else
        @sort_by = sort_options[params[:sort_by]]
      end

      @list = build_list

    end

    # .order() is vulnerable to SQL injection, so I'm abstracting its argument
    # from the form with this hash. 
    def sort_options
      {
        "Newest": "created_at DESC",
        "Oldest": "created_at ASC",
        "Alphabetic": "name"
      }
    end

    # Default sorting method
    def sort_default
      "Newest"
    end


    private

    def build_list
      if @query
        query_string = "file_file_name LIKE :query OR
                        name LIKE :query OR
                        description LIKE :query"

        Document.where(query_string, {query: @query}
                      ).order(@sort_by).limit(@per_page).offset(@offset)
      else
        Document.order(@sort_by).limit(@per_page).offset(@offset)
      end
    end

  end

end
