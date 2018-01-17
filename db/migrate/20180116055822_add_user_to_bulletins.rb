class AddUserToBulletins < ActiveRecord::Migration[5.1]
  def change
    add_reference :bulletins, :user, foreign_key: true
  end
end
