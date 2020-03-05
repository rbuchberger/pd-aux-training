class CreateTrainingVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :training_videos do |t|
      t.text :title
      t.text :description
      t.text :url # URL to video
      t.text :yt_id # Youtube video id
      t.integer :custom_start # Custom video start time, seconds
      t.integer :custom_end # Custom video end time, seconds
      t.timestamps
    end
  end
end
