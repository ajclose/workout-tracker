require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(email: "test@example.com", password: "password", password_confirmation: "password", activated: true)
  end

  test "missing email" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {user: {email: '', password: "password1", password_confirmation: "password1"}}
    assert_template 'users/edit'
  end

  test "invalid email address" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {user: {email: 'test@invalid', password: "password1", password_confirmation: "password1"}}
    assert_template 'users/edit'
  end

  test "password doesn't meet length requirements" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {user: {email: @user.email, password: "foo", password_confirmation: "foo"}}
    assert_template 'users/edit'
  end

  test "passwords don't match" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {user: {email: @user.email, password: "password1", password_confirmation: "password2"}}
    assert_template 'users/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    email = "update@example.com"
    patch user_path(@user), params: {user: {email: email, password: '', password_confirmation: ''}}
    assert_not flash.empty?
    assert_redirected_to root_path
    @user.reload
    assert_equal email, @user.email
  end

end
