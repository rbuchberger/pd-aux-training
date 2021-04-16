class RemoveColumnsFromDocuments < ActiveRecord::Migration[6.1]
  def change
    change_table :documents do |t|
      t.remove :file_file_name, :file_content_type, :file_file_size, :file_updated_at
    end
  end
end
