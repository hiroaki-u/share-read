class AddCaptionToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :caption, :text
  end
end
