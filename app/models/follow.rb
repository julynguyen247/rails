class Follow < ApplicationRecord
  belongs_to :follower, class_name: "User", inverse_of: :active_follows
  belongs_to :followed, class_name: "User", inverse_of: :passive_follows

  validates :followed_id, uniqueness: { scope: :follower_id }
  validate :cannot_follow_self

  private

    def cannot_follow_self
      errors.add(:followed, "cannot be the same as the follower") if follower_id == followed_id
    end
end
