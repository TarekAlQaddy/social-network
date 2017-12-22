class User < ActiveRecord::Base
  # User Posts & Phone Number
  has_many :posts, dependent: :destroy
  has_many :phones, dependent: :destroy

  # User friendship
  has_many :friendships
  has_many :friends, through: :friendships, source: :friend

  # User Friend request
  has_many :sent_friend_requests, class_name: "FriendRequest", foreign_key: "requester_user_id"
  has_many :recieved_friend_requests, class_name: "FriendRequest", foreign_key: "asked_user_id"

  # user notifications
  has_many :notifications, as: :recipient

  # User profile picture
  has_attached_file :profile_picture,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :profile_picture, content_type: /\Aimage\/.*\z/

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
end
