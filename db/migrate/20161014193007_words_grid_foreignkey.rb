class WordsGridForeignkey < ActiveRecord::Migration
  def change
    add_column :words, :grid_id, :integer
    add_foreign_key :words, :grids
  end
end
