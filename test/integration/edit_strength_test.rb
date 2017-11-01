require 'test_helper'

class StrengthsEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(email: "test@example.com", password: "password", password_confirmation: "password", activated: true)
    @workout = Workout.create(date: "2017-09-25", user_id: @user.id)
    @strength = Strength.create!(movement: "deadlift", sets: 5, reps: 3, weight: 225, workout_id: @workout.id)
  end

  test "missing movement" do
    log_in_as(@user)
    get edit_workout_strength_path(@workout, @strength)
    assert_template 'strengths/edit'
    patch workout_strength_path(@workout, @strength), params: {strength: {movement: ''}}
    assert_template 'strengths/edit'
  end

  test "missing sets" do
    log_in_as(@user)
    get edit_workout_strength_path(@workout, @strength)
    assert_template 'strengths/edit'
    patch workout_strength_path(@workout, @strength), params: {strength: {sets: ''}}
    assert_template 'strengths/edit'
  end

  test "missing reps" do
    log_in_as(@user)
    get edit_workout_strength_path(@workout, @strength)
    assert_template 'strengths/edit'
    patch workout_strength_path(@workout, @strength), params: {strength: {reps: ''}}
    assert_template 'strengths/edit'
  end

  test "missing weight" do
    log_in_as(@user)
    get edit_workout_strength_path(@workout, @strength)
    assert_template 'strengths/edit'
    patch workout_strength_path(@workout, @strength), params: {strength: {weight: ''}}
    assert_template 'strengths/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_workout_strength_path(@workout, @strength)
    assert_template 'strengths/edit'
    weight = 205
    patch workout_strength_path(@workout, @strength), params: {strength: {weight: weight}}
    assert_not flash.empty?
    assert_redirected_to edit_workout_strength_path(@workout, @strength)
    @strength.reload
    assert_equal weight, @strength.weight
  end

end
