class CreateMoveSequences < ActiveRecord::Migration
  def change
    create_table :move_sequences do |t|

      t.timestamps null: false
      t.float :score, null: false, default: 0
      t.string :word, null: true
      t.references :player, foreign_key: true
      t.references :game, foreign_key: true
    end
  end
end
