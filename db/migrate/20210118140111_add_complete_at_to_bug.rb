class AddCompleteAtToBug < ActiveRecord::Migration[6.1]
  def change
    add_column :bugs, :completed_at, :timestamp
  end
end
