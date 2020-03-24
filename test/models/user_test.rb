require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: 'testuser', password: '12345678')
    # @user = users(:valid)
  end
  test "user can not be saved without a user name" do
    @user.username = nil
    refute @user.valid?, 'User saved without a user name'
    refute_nil @user.errors[:username], 'no validation error for user name'
  end

  test "user name should be unique" do
    # user = User.new(username: "testuser", password: "12345678")
    user = users(:valid)
    user.save
    user = users(:valid)
    refute user.save
    assert_equal(user.errors.messages, username: ["has already been taken"])
  end

  test "password length must not be less than 5 characters" do
    # user = User.new(username: "testuser", password: "1234")
    user = users(:invalid_password)
    refute user.save
    assert_includes user.errors.full_messages, "Password must be at least 5 characters"
  end
end
