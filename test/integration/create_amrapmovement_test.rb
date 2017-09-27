require 'test_helper'

class CreateAmrapmovementTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(email: "test@example.com", password: "password", password_confirmation: "password", activated: true)
    @workout = Workout.create(date: "2017-09-25", tracked: true, user_id: @user.id)
    @amrap = Amrap.create(time: 10, score: 5, workout_id: @workout.id)
  end

  test "missing movement name" do
    log_in_as(@user)
    get new_amrap_amrapmovement_path(@amrap)
    assert_no_difference 'Amrapmovement.count' do
      post amrap_amrapmovements_path, params: { amrapmovement: {rx_movement: "", scaled_movement: "" }}
    end
    assert_template 'amrapmovements/new'
  end

  test "valid submission" do
    log_in_as(@user)
    get new_amrap_amrapmovement_path(@amrap)
    assert_difference 'Amrapmovement.count', 1 do
      post amrap_amrapmovements_path, params: { amrapmovement: {rx_movement: "deadlift", rx_reps: 5, rx_weight: 255, rx_unit: "lbs" }}
    end
    assert_not flash.empty?
  end

end
