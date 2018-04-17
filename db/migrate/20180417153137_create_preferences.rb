class CreatePreferences < ActiveRecord::Migration[5.1]
  def change
    create_table :preferences do |t|
      t.belongs_to :user, index: true

      # All users:
      t.boolean :bulletin_notify, default: true
      t.boolean :document_notify, default: false
      
      # Admin related:
      t.boolean :user_signup_notify, default: false
      t.boolean :user_deactivate_notify, default: false
      t.timestamps
    end
  end
end
