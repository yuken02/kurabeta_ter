class Tab < ApplicationRecord
  belongs_to :user
  has_many :keywords, dependent: :destroy
end
