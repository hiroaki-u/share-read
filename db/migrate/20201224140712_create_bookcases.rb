class CreateBookcases < ActiveRecord::Migration[6.0]
  def change
    create_table :bookcases do |t|
      t.integer :read
      t.references :book, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps

      t.index [:user_id, :book_id], unique: true
    end

    add_foreign_key :bookcases, :books, column: :book_id , primary_key: :isbn
  end
end