class Keyword < ApplicationRecord
  belongs_to :tab

  validates :word, presence: true
end
