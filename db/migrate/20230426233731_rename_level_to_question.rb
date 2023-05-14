class RenameLevelToQuestion < ActiveRecord::Migration[6.0]
  def change
    rename_column :questions, :level, :level_id
  end
end
