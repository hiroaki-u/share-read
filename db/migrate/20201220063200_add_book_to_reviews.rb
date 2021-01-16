# frozen_string_literal: true

class AddBookToReviews < ActiveRecord::Migration[6.0]
  def change
    add_reference :reviews, :book, null: false
  end
end
