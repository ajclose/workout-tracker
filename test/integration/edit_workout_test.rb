require 'test_helper'

class WorkoutsEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(email: "test@example.com", password: "password", password_confirmation: "password", activated: true)
    @workout = Workout.create(date: "2017-09-25", tracked: true, user_id: @user.id)
  end

  test "missing date" do
    log_in_as(@user)
    get edit_workout_path(@workout)
    assert_template 'workouts/edit'
    patch workout_path(@workout), params: {workout: {date: ''}}
    assert_template 'workouts/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_workout_path(@workout)
    assert_template 'workouts/edit'
    date = '2017-09-26'
    patch workout_path(@workout), params: {workout: {date: date}}
    assert_not flash.empty?
    assert_redirected_to @workout
    @workout.reload
    assert_equal date, @workout.date
  end

end
