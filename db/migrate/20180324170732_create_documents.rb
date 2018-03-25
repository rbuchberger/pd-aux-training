class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.attachment :file

      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
