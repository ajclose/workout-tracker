require 'test_helper'

class RftmovementTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: "test@example.com", password: "password", password_confirmation: "password")
    @workout = Workout.create!(date: "2017-09-25", user_id: @user.id)
    @rft = Rft.create!(rounds: 10, score: "5:00", workout_id: @workout.id)
    @rftmovement = Rftmovement.create!(rx_movement: "deadlift", rx_reps: 5, rx_weight: 155, rx_unit: "lbs", rft_id: @rft.id)
    @rftmovement1 = Rftmovement.create!(rx_movement: "row", rx_reps: 500, rx_weight: '', rx_unit: "meters", rft_id: @rft.id)
    @rftmovement2 = Rftmovement.create!(rx_movement: "front squat", rx_reps: 5, rx_weight: 95, rx_unit: "lbs", scaled_movement: "front squat", scaled_reps: 5, scaled_weight: 95, scaled_unit: "lbs", rft_id: @rft.id)
  end

  test "should be valid" do
    assert @rftmovement.valid?
    assert @rftmovement1.valid?
    assert @rftmovement2.valid?
  end
end
