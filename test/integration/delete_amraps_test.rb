require 'test_helper'

class AmrapsDeleteTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(email: "test@example.com", password: "password", password_confirmation: "password", activated: true)
    @workout = Workout.create(date: "2017-09-25", tracked: true, user_id: @user.id)
    @amrap = Amrap.create!(time: "10", score: 10, workout_id: @workout.id)
  end

  test "successfully deletes workout" do
    log_in_as(@user)
    assert_difference "Amrap.count", -1 do
      delete workout_amrap_path(@workout, @amrap)
    end
    assert_not flash.empty?
    assert_redirected_to edit_workout_path(@workout)
  end

end
