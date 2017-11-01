require 'test_helper'

class StrengthControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(email: "test@example.com", password: "password", password_confirmation: "password", admin: true, activated: true)
    @user2 = User.create(email: "test2@example.com", password: "password", password_confirmation: "password", activated: true)
    @workout = Workout.create(date: "2017-09-25", user_id: @user.id)
    @strength = Strength.create(movement: "Deadlift", sets: 1, reps: 5, weight: 225, workout_id: @workout.id)
  end

  test "should redirect edit page when not logged in" do
    get edit_workout_strength_path(@workout, @strength)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch workout_strength_path(@workout, @strength), params: {strength: {movement: "Back squat"}}
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect when logged in as different user" do
    log_in_as(@user2)
    get edit_workout_strength_path(@workout, @strength)
    assert flash.empty?
    assert_redirected_to root_path
  end

  test "should redirect update when logged in as different user" do
    log_in_as(@user2)
    patch workout_strength_path(@workout, @strength), params: {strength: {movement: "Back squat"}}
    assert flash.empty?
    assert_redirected_to root_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Strength.count' do
      delete workout_strength_path(@workout, @strength)
    end
    assert_redirected_to login_path
  end

  test "should redirect destroy when not logged in as different user" do
    log_in_as(@user2)
    assert_no_difference 'Strength.count' do
      delete workout_strength_path(@workout, @strength)
    end
    assert_redirected_to root_path
  end
end
