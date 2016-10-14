class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|

      t.timestamps null: false
      t.string :word, null: false
      
    end
  end
end
