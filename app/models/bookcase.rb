# frozen_string_literal: true

class Bookcase < ApplicationRecord
  belongs_to :user
  belongs_to :book, primary_key: "isbn"
  validates_uniqueness_of :book_id, scope: :user_id
end
