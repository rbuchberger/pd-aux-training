module DocumentsHelper
  def page_controls(documents)
    return unless documents.page_count > 1

    render partial: 'pager',
           locals: DocumentPager.new(documents).locals
  end
end
