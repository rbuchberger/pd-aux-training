class ChangeVideos < ActiveRecord::Migration[5.1]
  def change
    remove_reference(:videos, :lessons, index: true)
    add_reference(:videos, :lesson, index: true)
  end
end
