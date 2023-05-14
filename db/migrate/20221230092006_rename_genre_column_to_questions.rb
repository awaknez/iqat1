class RenameGenreColumnToQuestions < ActiveRecord::Migration[6.0]
  def change
    rename_column :questions, :genre, :genre_id
  end
end
