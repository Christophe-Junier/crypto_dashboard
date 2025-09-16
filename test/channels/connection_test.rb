require "test_helper"

class ApplicationCable::ConnectionTest < ActionCable::Connection::TestCase
  test "connects with proper cookie" do
    @user = User.new(email: 'userone@example.com', password: "password123")
    @user.save!
    # Simulate the connection request with a cookie.
    cookies.encrypted[:user_id] = @user.id

    connect

    # Assert the connection identifier matches the fixture.
    assert_equal @user.id, connection.current_user.id
  end

  test "rejects connection without proper cookie" do
    assert_reject_connection { connect }
  end
end
