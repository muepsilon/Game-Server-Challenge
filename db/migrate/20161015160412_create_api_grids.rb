class CreateApiGrids < ActiveRecord::Migration
  def change
    create_table :api_grids do |t|

      t.timestamps null: false
    end
  end
end
