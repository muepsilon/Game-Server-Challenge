class CreateGrids < ActiveRecord::Migration
  def change
    create_table :grids do |t|

      t.timestamps null: false
      t.references :game, foreign_key: true
      t.text :text, null: false
    end
  end
end
