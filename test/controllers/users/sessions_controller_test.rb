require "test_helper"

class Users::SessionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = User.create!(email: "test@example.com", password: "password123")
  end

  test "should get sign in page" do
    get new_user_session_path
    assert_response :success
    assert_select "form[action='#{user_session_path}']"
  end

  test "should sign in user with valid credentials" do
    post user_session_path, params: { user: { email: @user.email, password: "password123" } }
    assert_redirected_to root_path # ou la page après login
    follow_redirect!
    assert_response :success
  end

  test "should not sign in user with invalid credentials" do
    post user_session_path, params: { user: { email: @user.email, password: "wrong" } }
    assert_response :unprocessable_content
  end

  test "should sign out user" do
    sign_in @user
    delete destroy_user_session_path
    assert_redirected_to root_path
  end
end
