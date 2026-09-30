require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "can follow and unfollow another user" do
    follower = User.create!(name: "Follower", email: "follower@example.com")
    followed = User.create!(name: "Followed", email: "followed@example.com")

    assert_difference("Follow.count") { follower.follow(followed) }
    assert follower.following?(followed)
    assert_includes followed.followers, follower

    assert_difference("Follow.count", -1) { follower.unfollow(followed) }
    assert_not follower.following?(followed)
  end

  test "cannot follow the same user twice" do
    follower = users(:one)
    followed = users(:two)

    relationship = follower.follow(followed)

    assert_not relationship.persisted?
    assert_includes relationship.errors[:followed_id], "has already been taken"
  end

  test "cannot follow itself" do
    user = users(:one)

    relationship = user.follow(user)

    assert_not relationship.persisted?
    assert_includes relationship.errors[:followed], "cannot be the same as the follower"
  end

  test "deleting a user deletes its follow relationships" do
    user = users(:one)

    assert_difference("Follow.count", -1) { user.destroy }
  end
end
