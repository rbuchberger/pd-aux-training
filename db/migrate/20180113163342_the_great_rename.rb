class TheGreatRename < ActiveRecord::Migration[5.1]
  def change
    rename_table :training_records, :completions
    rename_table :training_videos, :videos
    rename_table :training_requirements, :lessons
  end
end
