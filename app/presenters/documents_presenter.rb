module DocumentsPresenter
  class ProcessedDocuments
    include ActiveRecord::Sanitization::ClassMethods
    # This is a class designed to handle document library presentation. It
    # stands between the model and controller; it sorts, pageinates, and
    # searches documents.
    attr_reader :list, :page, :total_pages, :sort_by, :query

    def initialize(params = {})
      @query = params[:query]
      @sort_by = params[:sort_by].blank? ? sort_default : params[:sort_by]
      @page = params[:page].blank? ? 1 : params[:page].to_i
    end

    def params
      { sort_by: @sort_by, query: @query }
    end

    def sort_keys
      sort_options.keys
    end

    def sort_options
      {
        'Newest' =>  'updated_at DESC',
        'Oldest' => 'updated_at ASC',
        'Alphabetic' => 'name'
      }
    end

    def page_count
      @page_count ||= (document_count / per_page).ceil
    end

    def list
      @list ||= current_page(query.blank? ? documents : query_documents)
    end

    private

    def per_page
      30.0
    end

    def offset
      (page - 1) * per_page
    end

    def sort_default
      'Newest'
    end

    def sanitized_query
      "%#{sanitize_sql_like(query)}%"
    end

    def sort_by_val
      sort_options[sort_by]
    end

    def query_arg
      "name LIKE :query OR description LIKE :query"
    end

    def documents
      Document.includes(file_attachment: :blob)
    end

    def current_page(list)
      list.order(sort_by_val).limit(per_page).offset(offset)
    end

    def query_documents
      documents.where(query_arg, {query: sanitized_query})
    end

    def document_count
      query.blank? ? documents.count : query_documents.count
    end
  end
end
