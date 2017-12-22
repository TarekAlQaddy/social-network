class FriendRequest < ApplicationRecord
  enum status: [:pending, :accepted, :rejected]

  belongs_to :requester, class_name: "User", foreign_key: "requester_user_id"
  belongs_to :asked, class_name: "User", foreign_key: "asked_user_id"
end
