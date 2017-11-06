require 'test_helper'

class RftTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: "test@example.com", password: "password", password_confirmation: "password")
    @workout = Workout.create!(date: "2017-09-25", user_id: @user.id)
    @rft = Rft.create!(rounds: 5, score: "8:55", notes: "This is a crazy workout!", workout_id: @workout.id)
  end

  test "should be valid" do
    assert @rft.valid?
  end

  test "rounds should be present" do
    @rft.rounds = ""
    assert_not @rft.valid?
  end
end
