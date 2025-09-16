require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: "userone@example.com", password: "password123")
  end

  test "is valid with valid attributes" do
    assert @user.valid?
  end

  test "is invalid without email" do
    @user.email = nil
    assert_not @user.valid?
    assert_includes @user.errors[:email], I18n.t("activerecord.errors.models.user.attributes.email.blank")
  end

  test "is invalid with invalid email" do
    @user.email = "invalid_email"
    assert_not @user.valid?
    assert_includes @user.errors[:email], I18n.t("activerecord.errors.models.user.attributes.email.invalid")
  end

  test "is invalid without password" do
    @user.password = nil
    assert_not @user.valid?
    assert_includes @user.errors[:password], I18n.t("activerecord.errors.models.user.attributes.password.blank")
  end

  test "is invalid when password is too short" do
    @user.password = "123"
    @user.password_confirmation = "123"
    assert_not @user.valid?
    assert_includes @user.errors[:password], I18n.t("activerecord.errors.models.user.attributes.password.too_short")
  end

  test "is invalid when password is too long" do
    @user.password = "123dfsfsoifjsopfjsifjspoifjspofijspfjspfjsdfpsjfspfjsdpfsdojfspfjspofsjfdsfsfsfsffsdsfsfsfsfs123dfsfsoifjsopfjsifjspoifjspofijspfjspfjsdfpsjfspfjsdpfsdojfspfjspofsjfdsfsfsfsffsdsfsfsfsfs"
    @user.password_confirmation = "123dfsfsoifjsopfjsifjspoifjspofijspfjspfjsdfpsjfspfjsdpfsdojfspfjspofsjfdsfsfsfsffsdsfsfsfsfs123dfsfsoifjsopfjsifjspoifjspofijspfjspfjsdfpsjfspfjsdpfsdojfspfjspofsjfdsfsfsfsffsdsfsfsfsfs"
    assert_not @user.valid?
    assert_includes @user.errors[:password], I18n.t("activerecord.errors.models.user.attributes.password.too_long")
  end

  test "email must be unique" do
    @user.save!
    @user_2 = User.new(email: @user.email, password: "password123")
    assert_not @user_2.valid?
    assert_includes @user_2.errors[:email], I18n.t("activerecord.errors.models.user.attributes.email.taken")
  end

  test "display_name returns first part of email" do
    assert_equal "Userone", @user.display_name
  end
end
