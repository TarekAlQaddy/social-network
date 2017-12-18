class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  after_create :create_inverse, unless: :has_inverse?
  after_destroy :destroy_inverses, if: :has_inverse?

  def create_inverse
    self.class.create(inverse_friendship_condition)
  end

  def destroy_inverses
    inverses.destroy_all
  end

  def has_inverse?
    self.class.exists?(inverse_friendship_condition)
  end

  def inverses
    self.class.where(inverse_friendship_condition)
  end

  def inverse_friendship_condition
    {user_id: friend_id, friend_id: user_id}
  end
end
