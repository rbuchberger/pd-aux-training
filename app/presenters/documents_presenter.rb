module DocumentsPresenter

  class ProcessedDocuments
    # This is a class designed to handle document library presentation. It
    # stands between the model and controller; it sorts, pageinates, and
    # searches documents to make the index page more manageable and useful. This
    # logic doesn't belong in the controller, or the model, so it gets its own
    # class.

    # List is the list of documents, page is the current page number, total
    # pages is the total number of pages. 
    attr_reader: :list, :page, :total_pages

    def initialize(params)

      # per_page is the number of documents to display per page; it's hard-coded
      # to 30 for now but I may decide to make this user-selectable in the
      # future.
      @per_page = 30
      @offset = @page * @per_page

      @query   = params[:query].blank?   ?  false         : params[:query]
      @sort_by = params[:sort_by].blank? ?  :date_created : params[:sort_by]
      @page    = params[:page].blank?    ?  1             : params[:page].to_i

      build_list

    end

    private

    def build_list
      if @query
        query_string = "file_file_name LIKE %:query% OR
                        name LIKE %:query% OR
                        description LIKE %:query%"

        Document.where(query_string, {query: @query}
                      ).order(@sort_by).limit(@per_page).offset(@offset)
      else
        Document.order(@sort_by).limit(@per_page).offset(@offset)
      end
    end

  end

end
