class CreatePreferences < ActiveRecord::Migration[5.1]
  def change
    create_table :preferences do |t|
      t.belongs_to :user, index: true

      # All users:
      t.boolean :bulletin_notify
      t.boolean :document_notify
      
      # Admin related:
      t.boolean :user_signup_notify
      t.boolean :user_deactivate_notify
      t.timestamps
    end
  end
end
