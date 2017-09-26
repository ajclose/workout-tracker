require 'test_helper'

class CreateWorkoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(email: "test@example.com", password: "password", password_confirmation: "password", activated: true)
  end

  test "missing date" do
    log_in_as(@user)
    get new_workout_path
    assert_no_difference 'Workout.count' do
      post workouts_path, params: { workout: { date: '', user_id: @user.id}}
    end
    assert_template 'workouts/new'
  end

  test "valid submission" do
    log_in_as(@user)
    get new_workout_path
    assert_difference 'Workout.count', 1 do
      post workouts_path, params: { workout: { date: '2017-09-25', user_id: @user.id}}
    end
    assert_not flash.empty?
  end

end
