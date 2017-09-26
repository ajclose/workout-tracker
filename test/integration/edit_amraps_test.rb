require 'test_helper'

class AmrapsEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(email: "test@example.com", password: "password", password_confirmation: "password", activated: true)
    @workout = Workout.create(date: "2017-09-25", tracked: true, user_id: @user.id)
    @amrap = Amrap.create!(time: "10", score: 10, workout_id: @workout.id)
  end

  test "missing time" do
    log_in_as(@user)
    get edit_workout_amrap_path(@workout, @amrap)
    assert_template 'amraps/edit'
    patch workout_amrap_path(@workout, @amrap), params: {amrap: {time: ''}}
    assert_template 'amraps/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_workout_amrap_path(@workout, @amrap)
    assert_template 'amraps/edit'
    time = '11'
    patch workout_amrap_path(@workout, @amrap), params: {amrap: {time: time}}
    assert_not flash.empty?
    assert_redirected_to edit_workout_amrap_path(@workout, @amrap)
    @amrap.reload
    assert_equal time, @amrap.time
  end

end
