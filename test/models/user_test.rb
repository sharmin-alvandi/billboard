require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user can not be saved without a user name" do
    user = User.new(username: nil, password: "12345678")
    assert_not user.save
  end
end
