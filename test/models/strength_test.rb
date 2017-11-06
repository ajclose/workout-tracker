require 'test_helper'

class StrengthTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: "test@example.com", password: "password", password_confirmation: "password")
    @workout = Workout.create!(date: "2017-09-25", user_id: @user.id)
    @strength = Strength.create!(movement: "Deadlift", sets: 1, reps: 5, weight: 225, notes: "This was a challenge", workout_id: @workout.id)
  end

  test "should be valid" do
    assert @strength.valid?
  end

  test "movement should be present" do
    @strength.movement = ""
    assert_not @strength.valid?
  end

  test "sets should be present" do
    @strength.sets = ""
    assert_not @strength.valid?
  end

  test "reps should be present" do
    @strength.reps = ""
    assert_not @strength.valid?
  end

  test "weight should be present" do
    @strength.weight = ""
    assert_not @strength.valid?
  end
end
