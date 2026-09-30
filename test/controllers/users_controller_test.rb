require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { email: @user.email, name: @user.name } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { email: @user.email, name: @user.name } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end

  test "should follow user" do
    follower = User.create!(name: "Another user", email: "another@example.com")

    assert_difference("Follow.count") do
      post follow_user_url(@user), params: { follower_id: follower.id }
    end

    assert_redirected_to user_url(@user)
    assert follower.following?(@user)
  end

  test "should not follow self" do
    assert_no_difference("Follow.count") do
      post follow_user_url(@user), params: { follower_id: @user.id }
    end

    assert_redirected_to user_url(@user)
  end

  test "should unfollow user" do
    follower = users(:one)
    followed = users(:two)

    assert_difference("Follow.count", -1) do
      delete unfollow_user_url(followed), params: { follower_id: follower.id }
    end

    assert_redirected_to user_url(followed)
    assert_not follower.following?(followed)
  end
end
