class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :notifiable, polymorphic: true
      t.integer :user_id
      t.boolean :is_unread, default: true

      t.timestamps
    end
    add_index :notifications, :user_id
  end
end
