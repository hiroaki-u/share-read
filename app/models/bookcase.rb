class Bookcase < ApplicationRecord
  belongs_to :user
  belongs_to :book, primary_key: "isbn"
  validates :user_id, :book_id, uniqueness: true
end