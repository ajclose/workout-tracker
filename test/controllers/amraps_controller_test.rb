require 'test_helper'

class AmrapsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(email: "test@example.com", password: "password", password_confirmation: "password", admin: true, activated: true)
    @user2 = User.create(email: "test2@example.com", password: "password", password_confirmation: "password", activated: true)
    @workout = Workout.create(date: "2017-09-25", user_id: @user.id)
    @amrap = Amrap.create(time: "10", score: 5, workout_id: @workout.id)
  end

  test "should redirect edit page when not logged in" do
    get edit_workout_amrap_path(@workout, @amrap)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch workout_amrap_path(@workout, @amrap), params: {amrap: {time: "11"}}
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as different user" do
    log_in_as(@user2)
    get edit_workout_amrap_path(@workout, @amrap)
    assert flash.empty?
    assert_redirected_to root_path
  end

  test "should redirect update when logged in as different user" do
    log_in_as(@user2)
    patch workout_amrap_path(@workout, @amrap), params: {amrap: {time: "11"}}
    assert flash.empty?
    assert_redirected_to root_path
  end

  test "should redirect index page when not logged in" do
    get amraps_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect show page when not logged in" do
    get workout_amrap_path(@workout, @amrap)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect show when logged in as different user" do
    log_in_as(@user2)
    get workout_amrap_path(@workout, @amrap)
    assert flash.empty?
    assert_redirected_to root_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Amrap.count' do
      delete workout_amrap_path(@workout, @amrap)
    end
    assert_redirected_to login_path
  end

  test "should redirect destroy when not logged in as different user" do
    log_in_as(@user2)
    assert_no_difference 'Amrap.count' do
      delete workout_amrap_path(@workout, @amrap)
    end
    assert_redirected_to root_path
  end
  end
