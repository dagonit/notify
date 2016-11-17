class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.text :description
      t.integer :user_id
      t.boolean :active

      t.timestamps
    end
  end
end
