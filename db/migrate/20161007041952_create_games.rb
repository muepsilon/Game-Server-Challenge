class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|

      t.timestamps null: false
      t.string :gameid, null: false
      t.integer :status, :default => 0, :null => false
    end
  end
end
