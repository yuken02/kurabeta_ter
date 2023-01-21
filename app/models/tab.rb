class Tab < ApplicationRecord
  belongs_to :user
  has_many :keywords, dependent: :destroy

  validates :name, presence: true
end
