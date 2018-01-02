class CreateTrainingRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :training_records do |t|
      t.belongs_to :user, index: true
      t.belongs_to :training_video, index: true
      t.timestamps
    end
  end
end
