class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.bigint :visitor_id
      t.bigint :visited_id
      t.bigint :review_id
      t.bigint :comment_id
      t.string :action
      t.boolean :checked

      t.timestamps
    end
  end
end
