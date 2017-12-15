class CreateTimecards < ActiveRecord::Migration[5.1]
  def change
    create_table :timecards do |t|
      t.belongs_to :user, index: true
      t.text :description
      t.timestamps
      t.datetime :start
      t.datetime :end
    end
  end
end
