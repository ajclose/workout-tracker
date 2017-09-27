require 'test_helper'

class AmrapmovementsEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(email: "test@example.com", password: "password", password_confirmation: "password", activated: true)
    @workout = Workout.create(date: "2017-09-25", tracked: true, user_id: @user.id)
    @amrap = Amrap.create!(time: "10", score: 10, workout_id: @workout.id)
    @amrapmovement = Amrapmovement.create!(rx_movement: "front squat", rx_reps: 5, rx_weight: 95, rx_unit: "lbs", scaled_movement: "front squat", scaled_reps: 5, scaled_weight: 95, scaled_unit: "lbs", amrap_id: @amrap.id)
  end

  test "missing movement name" do
    log_in_as(@user)
    get edit_amrap_amrapmovement_path(@amrap, @amrapmovement)
    assert_template 'amrapmovements/edit'
    patch amrap_amrapmovement_path(@amrap, @amrapmovement), params: {amrapmovement: {rx_movement: "", scaled_movement: ""}}
    assert_template 'amrapmovements/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_amrap_amrapmovement_path(@amrap, @amrapmovement)
    assert_template 'amrapmovements/edit'
    rx_reps = 11
    patch amrap_amrapmovement_path(@amrap, @amrapmovement), params: {amrapmovement: {rx_reps: rx_reps}}
    assert_not flash.empty?
    assert_redirected_to edit_workout_amrap_path(@workout, @amrap)
    @amrapmovement.reload
    assert_equal rx_reps, @amrapmovement.rx_reps
  end

end
