class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book ,primary_key: "isbn"

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favored, through: :favorites, source: :user

end