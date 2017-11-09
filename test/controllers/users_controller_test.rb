require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(email: "test@example.com", password: "password", password_confirmation: "password", admin: true, activated: true)
    @user2 = User.create(email: "test2@example.com", password: "password", password_confirmation: "password", activated: true)
  end

  test "should redirect edit page when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: {user: {email: @user.email}}
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect when logged in as different user" do
    log_in_as(@user2)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_path
  end

  test "should redirect update when logged in as different user" do
    log_in_as(@user2)
    patch user_path(@user), params: {user: {email: @user.email}}
    assert flash.empty?
    assert_redirected_to root_path
  end

  test "should not allow admin attribute to be edited via the web" do
    log_in_as(@user2)
    patch user_path(@user2), params: {user: {email: @user.email, admin: true}}
    assert_not @user2.admin?
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_path
  end

  test "should redirect destroy when not logged in as admin" do
    log_in_as(@user2)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_path
  end
end
