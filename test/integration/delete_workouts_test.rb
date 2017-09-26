require 'test_helper'

class WorkoutsDeleteTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(email: "test@example.com", password: "password", password_confirmation: "password", activated: true)
    @workout = Workout.create(date: "2017-09-25", tracked: true, user_id: @user.id)
  end

  test "successfully deletes workout" do
    log_in_as(@user)
    assert_difference "Workout.count", -1 do
      delete workout_path(@workout)
    end
    assert_not flash.empty?
    assert_redirected_to root_path
  end

end
