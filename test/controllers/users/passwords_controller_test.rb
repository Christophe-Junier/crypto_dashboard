require "test_helper"

class Users::PasswordsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers  # pour sign_in/sign_out

  def setup
    @user = User.create!(email: "test@example.com", password: "password123")
  end

  # --- GET /resource/password/new ---
  test "should get new password page" do
    get new_user_password_path
    assert_response :success
    assert_select "form[action='#{user_password_path}']"
  end

  # --- POST /resource/password ---
  test "should send password reset instructions" do
    post user_password_path, params: { user: { email: @user.email } }
    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_response :success
  end

  # --- GET /resource/password/edit ---
  test "should get edit password page with token" do
    # Générer un token de reset
    token = @user.send_reset_password_instructions
    get edit_user_password_path(reset_password_token: token)
    assert_response :success
    assert_select "form[action='#{user_password_path}']"
  end

  # --- PUT /resource/password ---
  test "should reset password with valid token" do
    token = @user.send_reset_password_instructions
    put user_password_path,
        params: { user: { reset_password_token: token, password: "newpassword123", password_confirmation: "newpassword123" } }
    assert_redirected_to root_path  # Devise redirect par défaut
    @user.reload
    assert @user.valid_password?("newpassword123")
  end

  # --- PUT /resource/password with invalid token ---
  test "should not reset password with invalid token" do
    put user_password_path,
        params: { user: { reset_password_token: "wrongtoken", password: "newpassword123", password_confirmation: "newpassword123" } }
    assert_response :unprocessable_content
  end
end
