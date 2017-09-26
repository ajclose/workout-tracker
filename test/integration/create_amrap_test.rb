require 'test_helper'

class CreateAmrapTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(email: "test@example.com", password: "password", password_confirmation: "password", activated: true)
    @workout = Workout.create(date: "2017-09-25", tracked: true, user_id: @user.id)
  end

  test "missing time" do
    log_in_as(@user)
    get new_workout_amrap_path(@workout)
    assert_no_difference 'Amrap.count' do
      post workout_amraps_path, params: { amrap: { time: '', workout_id: @workout.id}}
    end
    assert_template 'amraps/new'
  end

  test "valid submission" do
    log_in_as(@user)
    get new_workout_amrap_path(@workout)
    assert_difference 'Amrap.count', 1 do
    post workout_amraps_path, params: { amrap: { time: '10', workout_id: @workout.id}}
    end
    assert_not flash.empty?
  end

end
