class CreateFriendRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :friend_requests do |t|
      t.integer :requester_user_id
      t.integer :asked_user_id

      t.timestamps
    end
  end
end
