class CreateApiWords < ActiveRecord::Migration
  def change
    create_table :api_words do |t|

      t.timestamps null: false
    end
  end
end
