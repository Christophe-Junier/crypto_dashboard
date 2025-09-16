require "test_helper"

class UserTest < ActiveSupport::TestCase
  fixtures :users

  test "is valid with valid attributes" do
    assert users(:one).valid?
  end

  test "is invalid without email" do
    users(:one).email = nil
    assert_not users(:one).valid?
    assert_includes users(:one).errors[:email], I18n.t('activerecord.errors.models.user.attributes.email.blank')
  end

  test "is invalid with invalid email" do
    users(:one).email = "invalid_email"
    assert_not users(:one).valid?
    assert_includes users(:one).errors[:email], I18n.t('activerecord.errors.models.user.attributes.email.invalid')
  end

  test "is invalid without password" do
    user = User.new(email: "no_password@example.com", password: nil)
    assert_not user.valid?
    assert_includes user.errors[:password], I18n.t('activerecord.errors.models.user.attributes.password.blank')
  end

  test "is invalid when password is too short" do
    users(:one).password = "123"
    users(:one).password_confirmation = "123"
    assert_not users(:one).valid?
    assert_includes users(:one).errors[:password], I18n.t('activerecord.errors.models.user.attributes.password.too_short')
  end

  test "is invalid when password is too long" do
    users(:one).password = "123dfsfsoifjsopfjsifjspoifjspofijspfjspfjsdfpsjfspfjsdpfsdojfspfjspofsjfdsfsfsfsffsdsfsfsfsfs123dfsfsoifjsopfjsifjspoifjspofijspfjspfjsdfpsjfspfjsdpfsdojfspfjspofsjfdsfsfsfsffsdsfsfsfsfs"
    users(:one).password_confirmation = "123dfsfsoifjsopfjsifjspoifjspofijspfjspfjsdfpsjfspfjsdpfsdojfspfjspofsjfdsfsfsfsffsdsfsfsfsfs123dfsfsoifjsopfjsifjspoifjspofijspfjspfjsdfpsjfspfjsdpfsdojfspfjspofsjfdsfsfsfsffsdsfsfsfsfs"
    assert_not users(:one).valid?
    assert_includes users(:one).errors[:password], I18n.t('activerecord.errors.models.user.attributes.password.too_long')
  end

  test "email must be unique" do
    users(:two).email = users(:one).email
    assert_not users(:two).valid?
    assert_includes users(:two).errors[:email], I18n.t('activerecord.errors.models.user.attributes.email.taken')
  end

  test "display_name returns first part of email" do
    assert_equal "One", users(:one).display_name
  end
end