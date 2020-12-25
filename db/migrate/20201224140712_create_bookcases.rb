class CreateBookcases < ActiveRecord::Migration[6.0]
  def change
    create_table :bookcases do |t|
      t.integer :read
      t.references :book, null: false

      t.timestamps
    end

    add_reference :bookcases, :user, null: false, foreign_key: true
    add_foreign_key :bookcases, :books, column: :book_id , primary_key: :isbn
    add_index :bookcases, [:user_id, :book_id], unique: true
  end
end