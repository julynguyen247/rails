class User < ApplicationRecord
  has_many :active_follows,
           class_name: "Follow",
           foreign_key: :follower_id,
           inverse_of: :follower,
           dependent: :destroy
  has_many :following, through: :active_follows, source: :followed

  has_many :passive_follows,
           class_name: "Follow",
           foreign_key: :followed_id,
           inverse_of: :followed,
           dependent: :destroy
  has_many :followers, through: :passive_follows, source: :follower

  def follow(user)
    active_follows.create(followed: user)
  end

  def unfollow(user)
    active_follows.find_by(followed: user)&.destroy
  end

  def following?(user)
    following.exists?(user.id)
  end
end
