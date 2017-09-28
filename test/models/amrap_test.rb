require 'test_helper'

class AmrapTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: "test@example.com", password: "password", password_confirmation: "password")
    @workout = Workout.create!(date: "2017-09-25", user_id: @user.id)
    @amrap = Amrap.create!(time: 10, score: 5, workout_id: @workout.id)
  end

  test "should be valid" do
    assert @amrap.valid?
  end

  test "time should be present" do
    @amrap.time = ""
    assert_not @amrap.valid?
  end
end
