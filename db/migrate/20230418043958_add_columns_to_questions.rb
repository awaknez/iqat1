class AddColumnsToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :image, :text
    add_column :questions, :priority, :integer
    add_column :questions, :level, :integer
  end
end
