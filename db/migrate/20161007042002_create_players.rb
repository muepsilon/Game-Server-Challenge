class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|

      t.timestamps null: false
      t.string :playerid, null: false
      t.float :points, null: false, default: 0
      t.boolean :admin, null: false, default: false
      t.references :game, foreign_key: true
    end
  end
end
