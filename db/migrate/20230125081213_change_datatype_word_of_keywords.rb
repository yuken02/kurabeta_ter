class ChangeDatatypeWordOfKeywords < ActiveRecord::Migration[6.1]
  def change
    change_column :keywords, :word, :string
  end
end
