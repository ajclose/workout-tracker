require 'test_helper'

class WorkoutTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: "test@example.com", password: "password", password_confirmation: "password")
    @workout = Workout.create!(date: "2017-09-25", tracked: "true", user_id: @user.id)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "date should be present" do
    @workout.date = ""
    assert_not @workout.valid?
  end

end
