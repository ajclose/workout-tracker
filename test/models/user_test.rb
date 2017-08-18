require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(email: "test@example.com", password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "password should be present" do
    @user.password_digest = ""
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = "a" * 5
    @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "password and password_confirmation must be equal" do
    @user.password_confirmation = "password1"
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid email addresses" do
    valid_email_addresses = %w[user@test.com EMAIL@email.COM 1234@user.net email-e_u@email.com foo@bar.edu]
    valid_email_addresses.each do |email|
      @user.email = email
      assert @user.valid?, "#{email.inspect} should be valid."
    end
  end

  test "email validation should reject invalid email addresses" do
    invalid_email_addresses = %w[user@test,com user_at_test.com user@test. user@fizz_buzz.com foo@bizz+buzz.net for@bar..com]
    invalid_email_addresses.each do |email|
      @user.email = email
      assert_not @user.valid?, "#{email.inspect} should be invalid."
    end
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email address should be saved as lowercase" do
    email = "fooBAR@BAR.COM"
    @user.email = email
    @user.save
    assert_equal email.downcase, @user.reload.email
  end
end
