require 'test_helper'

class CreateRftTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(email: "test@example.com", password: "password", password_confirmation: "password", activated: true)
    @workout = Workout.create(date: "2017-09-25", user_id: @user.id)
  end

  test "missing rounds" do
    log_in_as(@user)
    get new_workout_rft_path(@workout)
    assert_no_difference 'Rft.count' do
      post workout_rfts_path, params: { rft: { rounds: '', workout_id: @workout.id}}
    end
    assert_template 'rfts/new'
  end

  test "valid submission" do
    log_in_as(@user)
    get new_workout_rft_path(@workout)
    assert_difference 'Rft.count', 1 do
    post workout_rfts_path, params: { rft: { rounds: 6, workout_id: @workout.id}}
    end
    assert_not flash.empty?
  end

end
