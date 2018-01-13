class Cleanup < ActiveRecord::Migration[5.1]
  def change
    # Remove yt_id from training videos
    remove_column :training_videos, :yt_id, :string

    # rename timecard start & end to clock_in and clock_out
    rename_column :timecards, :start, :clock_in
    rename_column :timecards, :end, :clock_out
  end
end
