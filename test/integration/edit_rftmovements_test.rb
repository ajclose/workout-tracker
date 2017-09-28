require 'test_helper'

class RftmovementsEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(email: "test@example.com", password: "password", password_confirmation: "password", activated: true)
    @workout = Workout.create(date: "2017-09-25", user_id: @user.id)
    @rft = Rft.create!(rounds: 10, score: "5:00", workout_id: @workout.id)
    @rftmovement = Rftmovement.create!(rx_movement: "front squat", rx_reps: 5, rx_weight: 95, rx_unit: "lbs", scaled_movement: "front squat", scaled_reps: 5, scaled_weight: 95, scaled_unit: "lbs", rft_id: @rft.id)
  end

  test "missing movement name" do
    log_in_as(@user)
    get edit_rft_rftmovement_path(@rft, @rftmovement)
    assert_template 'rftmovements/edit'
    patch rft_rftmovement_path(@rft, @rftmovement), params: {rftmovement: {rx_movement: "", scaled_movement: ""}}
    assert_template 'rftmovements/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_rft_rftmovement_path(@rft, @rftmovement)
    assert_template 'rftmovements/edit'
    rx_reps = 11
    patch rft_rftmovement_path(@rft, @rftmovement), params: {rftmovement: {rx_reps: rx_reps}}
    assert_not flash.empty?
    assert_redirected_to edit_workout_rft_path(@workout, @rft)
    @rftmovement.reload
    assert_equal rx_reps, @rftmovement.rx_reps
  end

end
