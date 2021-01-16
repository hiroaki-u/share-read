# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :user_image
      t.integer :gender
      t.date :birthday
      t.text :introduction

      t.timestamps
    end
  end
end
