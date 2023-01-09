class CreateKeywords < ActiveRecord::Migration[6.1]
  def change
    create_table :keywords do |t|

      t.timestamps
    end
  end
end
