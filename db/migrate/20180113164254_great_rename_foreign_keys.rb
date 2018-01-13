class GreatRenameForeignKeys < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :completions, :training_requirement_id
    rename_column :completions, :training_requirement_id, :lesson_id
    add_foreign_key :completions, :lesson_id, 

    remove_foreign_key :videos, :training_requirement_id
    rename_column :videos, :training_requirement_id, :lesson_id
    add_foreign_key :videos, :lesson_id
  end
end
