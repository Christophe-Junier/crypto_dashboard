require "test_helper"

class Users::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers  # pour sign_in/sign_out

  def setup
    @user = User.create!(email: "test@example.com", password: "password123")
  end

  # --- GET /resource/sign_up ---
  test "should get new registration page" do
    get new_user_registration_path
    assert_response :success
    assert_select "form[action='#{user_registration_path}']"
  end

  # --- POST /resource ---
  test "should create new user registration" do
    post user_registration_path, params: { user: { email: "newuser@example.com", password: "password123", password_confirmation: "password123" } }
    assert_redirected_to root_path # Devise redirige par défaut
    follow_redirect!
    assert_response :success
  end

  # --- GET /resource/edit ---
  test "should get edit registration page" do
    sign_in @user
    get edit_user_registration_path
    assert_response :success
    assert_select "form[action='#{user_registration_path}']"
  end

  # --- PUT /resource ---
  test "should update user registration" do
    sign_in @user
    put user_registration_path, params: { user: { email: "updated@example.com", current_password: "password123" } }
    assert_redirected_to root_path
    @user.reload
    assert_equal "updated@example.com", @user.email
  end

  # --- DELETE /resource ---
  test "should destroy user registration" do
    sign_in @user
    delete user_registration_path
    assert_redirected_to root_path
    assert_nil User.find_by(id: @user.id)
  end

  # --- GET /resource/cancel ---
  test "should get cancel registration page" do
    get cancel_user_registration_path
    assert_redirected_to new_user_registration_path # Devise redirige vers sign_up
  end

  # --- after_sign_up_path_for & after_inactive_sign_up_path_for ---
  test "after sign up paths are accessible" do
    post user_registration_path, params: { user: { email: "another@example.com", password: "password123", password_confirmation: "password123" } }
    # Devise appelle ces méthodes en interne, coverage de ton controller shell
    assert_redirected_to root_path
  end
end
