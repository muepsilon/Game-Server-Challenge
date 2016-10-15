class CreateApiPlayers < ActiveRecord::Migration
  def change
    create_table :api_players do |t|

      t.timestamps null: false
    end
  end
end
