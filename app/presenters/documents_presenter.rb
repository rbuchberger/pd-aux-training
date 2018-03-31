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
      @query = params[:query]
      @sort_by = params[:sort_by]
      @page = params[:page]

      # per_page is the number of documents to display per page; it's hard-coded
      # to 30 for now but I may decide to make this user-selectable in the
      # future.
      @per_page = 30
    end

    private

    # How many entries to skip before returning; for pageination. 
    def offset
      @page * @per_page
    end

  end

end
