# frozen_string_literal: true

class AddBookgenreidToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :book_genre_id, :string
  end
end
