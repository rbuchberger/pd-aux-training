class CreateTimecards < ActiveRecord::Migration[5.1]
  def change
    create_table :timecards do |t|

      t.timestamps
    end
  end
end
