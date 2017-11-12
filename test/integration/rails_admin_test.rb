require 'test_helper'

class RailsAdminTest < ActionDispatch::IntegrationTest

  def setup
    @admin = User.create!(email: "admin@example.com", password: "password", password_confirmation: "password", activated: true, admin: true)
    @user = User.create!(email: "user@example.com", password: "password", password_confirmation: "password", activated: true, admin: false)
  end

  test "Admin can view admin dashboard" do
    log_in_as(@admin)
    get rails_admin_path
    assert_template 'rails_admin/main/dashboard'
  end

  test "Non admin user can't view admin dashboard" do
    log_in_as(@user)
    get rails_admin_path
    follow_redirect!
    assert_template "workouts/index"
    assert_not flash.empty?
  end

  test "Non logged in user can't view admin dashboard" do
    get rails_admin_path
    follow_redirect!
    follow_redirect!
    assert_template "sessions/new"
    assert_not flash.empty?
  end

end
