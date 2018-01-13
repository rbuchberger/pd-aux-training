class TheGreatRenameForeignKeys < ActiveRecord::Migration[5.1]
  def change
    remove_reference(:completions, :training_requirement, index: true)
    add_reference(:completions, :lesson, index: true)

    remove_reference(:videos, :training_requirement, index: true)
    add_reference(:videos, :lessons, index: true)
  end
end
