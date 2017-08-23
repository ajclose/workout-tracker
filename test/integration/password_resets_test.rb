require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @user = User.create!(email: "test@example.com", password: "password", password_confirmation: "password", activated: true)
  end

  test "password resets with invalid email" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    post password_resets_path, params: { password_reset: { email: "" } }
    assert_not flash.empty?
    assert_template 'password_resets/new'
  end

  test "password resets with valid email" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    post password_resets_path, params: { password_reset: { email: @user.email } }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test "edit password with invalid email" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    post password_resets_path, params: { password_reset: { email: @user.email } }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to login_path
    user = assigns(:user)
    get edit_password_reset_path(user.reset_token, email: "")
    assert_redirected_to login_url
  end

  test "password resets with inactive user" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    post password_resets_path, params: { password_reset: { email: @user.email } }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to login_path
    user = assigns(:user)
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to login_path
  end

  test "edit password with wrong token" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    post password_resets_path, params: { password_reset: { email: @user.email } }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to login_path
    user = assigns(:user)
    get edit_password_reset_path('wrong token', email: user.email)
    assert_redirected_to login_url
  end

  test "edit password with correct token" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    post password_resets_path, params: { password_reset: { email: @user.email } }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to login_path
    user = assigns(:user)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", user.email
  end

  test "edit password with invalid password combination" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    post password_resets_path, params: { password_reset: { email: @user.email } }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to login_path
    user = assigns(:user)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", user.email
    patch password_reset_path(user.reset_token),
      params: { email: user.email,
                user: { password:              "password",
                        password_confirmation: "password1" } }
    assert_select 'div#error_explanation'
  end

  test "edit password with empty password" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    post password_resets_path, params: { password_reset: { email: @user.email } }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to login_path
    user = assigns(:user)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", user.email
    patch password_reset_path(user.reset_token),
    params: { email: user.email,
      user: { password:              "",
        password_confirmation: "" } }
    assert_select 'div#error_explanation'
  end

  test "edit password with valid password combination" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    post password_resets_path, params: { password_reset: { email: @user.email } }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to login_path
    user = assigns(:user)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", user.email
    patch password_reset_path(user.reset_token),
    params: { email: user.email,
      user: { password:              "foobaz",
        password_confirmation: "foobaz" } }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to user
  end

  test "expired token" do
    get new_password_reset_path
    post password_resets_path,
         params: { password_reset: { email: @user.email } }
    @user = assigns(:user)
    @user.update_attribute(:reset_sent_at, 3.hours.ago)
    patch password_reset_path(@user.reset_token),
          params: { email: @user.email,
                    user: { password:              "foobar",
                            password_confirmation: "foobar" } }
    assert_response :redirect
    follow_redirect!
    assert_match /password reset has expired/i, response.body
  end

end
