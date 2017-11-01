require 'test_helper'

class CreateStrengthTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(email: "test@example.com", password: "password", password_confirmation: "password", activated: true)
    @workout = Workout.create(date: "2017-09-25", user_id: @user.id)
  end

  test "missing movement" do
    log_in_as(@user)
    get new_workout_strength_path(@workout)
    assert_no_difference 'Strength.count' do
      post workout_strengths_path, params: { strength: { movement: "", sets: 5, reps: 3, weight: 125, workout_id: @workout.id}}
    end
    assert_template 'strengths/new'
  end

  test "missing sets" do
    log_in_as(@user)
    get new_workout_strength_path(@workout)
    assert_no_difference 'Strength.count' do
      post workout_strengths_path, params: { strength: { sets: "", movement: "deadlift", reps: 3, weight: 125, workout_id: @workout.id}}
    end
    assert_template 'strengths/new'
  end

  test "missing reps" do
    log_in_as(@user)
    get new_workout_strength_path(@workout)
    assert_no_difference 'Strength.count' do
      post workout_strengths_path, params: { strength: { movement: "deadlift", sets: 5, reps: '', weight: 125, workout_id: @workout.id}}
    end
    assert_template 'strengths/new'
  end

  test "missing weight" do
    log_in_as(@user)
    get new_workout_strength_path(@workout)
    assert_no_difference 'Strength.count' do
      post workout_strengths_path, params: { strength: { movement: "deadlift", sets: 5, reps: 3, weight: '', workout_id: @workout.id}}
    end
    assert_template 'strengths/new'
  end

  test "valid submission" do
    log_in_as(@user)
    get new_workout_strength_path(@workout)
    assert_difference 'Strength.count', 1 do
    post workout_strengths_path, params: { strength: { movement: "deadlift", sets: 5, reps: 3, weight: 225, workout_id: @workout.id}}
    end
    assert_not flash.empty?
  end

end
