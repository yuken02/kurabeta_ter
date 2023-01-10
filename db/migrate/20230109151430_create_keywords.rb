class CreateKeywords < ActiveRecord::Migration[6.1]
  def change
    create_table :keywords do |t|
      
      t.integer :tab_id, null: false
      t.text :word, null: false

      t.timestamps
    end
  end
end
