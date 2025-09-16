require "test_helper"

class ApplicationCable::ConnectionTest < ActionCable::Connection::TestCase
  test "connects with proper cookie" do
    # Simulate the connection request with a cookie.
    cookies.encrypted[:user_id] = users(:one).id

    connect

    # Assert the connection identifier matches the fixture.
    assert_equal users(:one).id, connection.current_user.id
  end

  test "rejects connection without proper cookie" do
    assert_reject_connection { connect }
  end
end
