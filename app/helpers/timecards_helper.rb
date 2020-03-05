module TimecardsHelper
  def admindex_table
    if @timecards.list.any?
      render 'admindex_table'
    else
      render 'admindex_table_empty'
    end
  end

  def admindex_table_rows
    render partial: 'admindex_table_rows', collection: @timecards.list, as: :timecard
  end
end
