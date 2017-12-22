class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.integer :recipient_id
      t.string :type

      t.timestamps
    end
  end
end
