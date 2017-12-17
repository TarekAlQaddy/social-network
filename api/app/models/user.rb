class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable, :confirmable
  include DeviseTokenAuth::Concerns::User
end
