require 'test_helper'

class CreateRftmovementTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(email: "test@example.com", password: "password", password_confirmation: "password", activated: true)
    @workout = Workout.create(date: "2017-09-25", user_id: @user.id)
    @rft = Rft.create(rounds: 10, score: "5:00", workout_id: @workout.id)
  end

  test "missing movement name" do
    log_in_as(@user)
    get new_rft_rftmovement_path(@rft)
    assert_no_difference 'Rftmovement.count' do
      post rft_rftmovements_path, params: { rftmovement: {rx_movement: "", scaled_movement: "" }}
    end
    assert_template 'rftmovements/new'
  end

  test "valid submission" do
    log_in_as(@user)
    get new_rft_rftmovement_path(@rft)
    assert_difference 'Rftmovement.count', 1 do
      post rft_rftmovements_path, params: { rftmovement: {rx_movement: "deadlift", rx_reps: 5, rx_weight: 255, rx_unit: "lbs" }}
    end
    assert_not flash.empty?
  end

end
