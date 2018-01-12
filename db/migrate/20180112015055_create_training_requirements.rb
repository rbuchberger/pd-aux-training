class CreateTrainingRequirements < ActiveRecord::Migration[5.1]
  def change
    # Create training requirements table
    create_table :training_requirements do |t|
      t.text :title
      t.text :description
      t.boolean :required?
      t.timestamps
    end
    
    # Rename training record foreign key
    rename_column :training_records, :training_video_id, :training_requirement_id

    # Add foreign key to training videos
    add_foreign_key :training_videos, :training_requirements
        
  end
end
