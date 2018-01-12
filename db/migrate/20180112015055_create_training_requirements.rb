class CreateTrainingRequirements < ActiveRecord::Migration[5.1]
  def change
    create_table :training_requirements do |t|

      t.timestamps
    end
  end
end
