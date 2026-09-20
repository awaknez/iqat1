class AddHintToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :hint, :text
  end
end