class CreateApiGames < ActiveRecord::Migration
  def change
    create_table :api_games do |t|

      t.timestamps null: false
    end
  end
end
