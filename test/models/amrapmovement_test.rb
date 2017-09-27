require 'test_helper'

class AmrapmovementTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: "test@example.com", password: "password", password_confirmation: "password")
    @workout = Workout.create!(date: "2017-09-25", tracked: "true", user_id: @user.id)
    @amrap = Amrap.create!(time: 10, score: 5, workout_id: @workout.id)
    @amrapmovement = Amrapmovement.create!(rx_movement: "deadlift", rx_reps: 5, rx_weight: 155, rx_unit: "lbs", amrap_id: @amrap.id)
    @amrapmovement1 = Amrapmovement.create!(rx_movement: "row", rx_reps: 500, rx_weight: '', rx_unit: "meters", amrap_id: @amrap.id)
    @amrapmovement2 = Amrapmovement.create!(rx_movement: "front squat", rx_reps: 5, rx_weight: 95, rx_unit: "lbs", scaled_movement: "front squat", scaled_reps: 5, scaled_weight: 95, scaled_unit: "lbs", amrap_id: @amrap.id)
  end

  test "should be valid" do
    assert @amrapmovement.valid?
    assert @amrapmovement1.valid?
    assert @amrapmovement2.valid?
  end
end
