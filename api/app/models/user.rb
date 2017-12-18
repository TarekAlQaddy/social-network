class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :phones, dependent: :destroy

  # user friendship
  has_many :friendships
  has_many :friends, through: :friendships, source: :friend

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
end
