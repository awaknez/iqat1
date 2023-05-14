class RenamePriorityToQuestion < ActiveRecord::Migration[6.0]
  def change
    rename_column :questions, :priority, :priority_id
  end
end
