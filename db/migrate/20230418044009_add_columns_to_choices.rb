class AddColumnsToChoices < ActiveRecord::Migration[6.0]
  def change
    add_column :choices, :image, :text
  end
end
