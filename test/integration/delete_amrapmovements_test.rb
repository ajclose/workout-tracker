require 'test_helper'

class AmrapmovementsDeleteTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(email: "test@example.com", password: "password", password_confirmation: "password", activated: true)
    @workout = Workout.create(date: "2017-09-25", user_id: @user.id)
    @amrap = Amrap.create!(time: "10", score: 10, workout_id: @workout.id)
    @amrapmovement = Amrapmovement.create!(rx_movement: "front squat", rx_reps: 5, rx_weight: 95, rx_unit: "lbs", scaled_movement: "front squat", scaled_reps: 5, scaled_weight: 95, scaled_unit: "lbs", amrap_id: @amrap.id)
  end

  test "successfully deletes amrap movement" do
    log_in_as(@user)
    assert_difference "Amrapmovement.count", -1 do
      delete amrap_amrapmovement_path(@amrap, @amrapmovement)
    end
    assert_not flash.empty?
    assert_redirected_to edit_workout_path(@workout)
  end

end
