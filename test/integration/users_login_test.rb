require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(email: "test@example.com", password: "password", password_confirmation: "password", activated: true)
  end

  test "login with valid information followed by logout" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {email: @user.email, password: @user.password}
    assert is_logged_in?
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'workouts/index'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to login_path
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
  end

  test "login with invalid email" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {email: "", password: @user.password}
    assert_template 'sessions/new'
    assert_not flash.empty?
    get login_path
    assert flash.empty?
  end

  test "login with invalid password" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {email: @user.password, password: ""}
    assert_template 'sessions/new'
    assert_not flash.empty?
    get login_path
    assert flash.empty?
  end

  test "login with remember me" do
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies['remember_token']
  end

  test "login without remember me" do
    log_in_as(@user, remember_me: '1')
    log_in_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end

end
