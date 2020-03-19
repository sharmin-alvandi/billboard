require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user can not be saved without a user name" do
    user = User.new(username: nil, password: "12345678")
    assert_not user.save
    assert_equal(user.errors.messages, username: ["can't be blank"])
  end

  test "user name should be unique" do
    user = User.new(username: "testuser", password: "12345678")
    user.save
    user = User.new(username: "testuser", password: "12345678")
    refute user.save
    assert_equal(user.errors.messages, username: ["has already been taken"])
  end

  test "password length must be more than 5 characters" do
    user = User.new(username: "testuser", password: "1234")
    refute user.save
    assert_equal(user.errors.messages, password: ["must be at least 5 characters"])
  end
end
