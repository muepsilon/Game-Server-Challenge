class CreateDictWords < ActiveRecord::Migration
  def change
    create_table :dict_words do |t|

      t.timestamps null: false
      t.string :word, null: false, index: true
      t.bigint :length, null: false 
    end
  end
end
