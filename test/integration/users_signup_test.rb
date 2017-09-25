require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @user = User.new(email: "test@example.com", password: "password", password_confirmation: "password", activated: true)
    @user.save
  end

  test "missing email" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { email: '', password: 'password', password_confirmation: 'password'}}
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation' do
      assert_select 'li', "Email can't be blank"
    end
  end

  test "invalid email address" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { email: 'foo@bar,com', password: 'password', password_confirmation: 'password'}}
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation' do
      assert_select 'li', "Email is invalid"
    end
  end

  test "missing password" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { email: 'foo@bar.com', password: '', password_confirmation: ''}}
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation' do
      assert_select 'li', "Password can't be blank"
    end
  end

  test "password doesn't meet length requirements" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { email: 'foo@bar.com', password: 'bar', password_confirmation: 'bar'}}
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation' do
      assert_select 'li', 'Password is too short (minimum is 6 characters)'
    end
  end

  test "passwords don't match" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { email: 'foo@bar.com', password: 'password', password_confirmation: 'password1'}}
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation' do
      assert_select 'li', "Password confirmation doesn't match Password"
    end
  end

  test "duplicate email" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { email: @user.email, password: 'password', password_confirmation: 'password'}}
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation' do
      assert_select 'li', "Email has already been taken"
    end
  end

  test "valid signup information with account validation" do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: { user: { email: 'foo@bar.com', password: 'password', password_confirmation: 'password'}}
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    log_in_as(user)
    assert_not is_logged_in?
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'workouts/index'
    assert is_logged_in?
  end
end
