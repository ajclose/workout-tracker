require 'test_helper'

class StrengthsDeleteTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(email: "test@example.com", password: "password", password_confirmation: "password", activated: true)
    @workout = Workout.create(date: "2017-09-25", user_id: @user.id)
    @strength = Strength.create!(movement: "deadlift", sets: 5, reps: 3, weight: 205, workout_id: @workout.id)
  end

  test "successfully deletes workout" do
    log_in_as(@user)
    assert_difference "Strength.count", -1 do
      delete workout_strength_path(@workout, @strength)
    end
    assert_not flash.empty?
    assert_redirected_to edit_workout_path(@workout)
  end

end
