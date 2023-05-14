class AddCommentaryToChoices < ActiveRecord::Migration[6.0]
  def change
    add_column :choices, :commentary, :string
  end
end
