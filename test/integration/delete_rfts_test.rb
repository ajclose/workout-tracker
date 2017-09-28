require 'test_helper'

class RftsDeleteTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(email: "test@example.com", password: "password", password_confirmation: "password", activated: true)
    @workout = Workout.create(date: "2017-09-25", user_id: @user.id)
    @rft = Rft.create!(rounds: 5, score: "11:20", workout_id: @workout.id)
  end

  test "successfully deletes workout" do
    log_in_as(@user)
    assert_difference "Rft.count", -1 do
      delete workout_rft_path(@workout, @rft)
    end
    assert_not flash.empty?
    assert_redirected_to edit_workout_path(@workout)
  end

end
