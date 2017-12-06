class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name, null: false
      t.string :badge_number, null: false
      t.integer :role, null: false, default: 0
      t.timestamps
    end
  end
end
