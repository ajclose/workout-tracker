require 'test_helper'

class RftmovementsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(email: "test@example.com", password: "password", password_confirmation: "password", admin: true, activated: true)
    @user2 = User.create(email: "test2@example.com", password: "password", password_confirmation: "password", activated: true)
    @workout = Workout.create(date: "2017-09-25", user_id: @user.id)
    @rft = Rft.create(rounds: 10, score: "5:00", workout_id: @workout.id)
    @rftmovement = Rftmovement.create(rx_movement: "front squat", rx_reps: 5, rx_weight: 95, rx_unit: "lbs", scaled_movement: "front squat", scaled_reps: 5, scaled_weight: 95, scaled_unit: "lbs", rft_id: @rft.id)
  end

  test "should redirect edit page when not logged in" do
    get edit_rft_rftmovement_path(@rft, @rftmovement)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch rft_rftmovement_path(@rft, @rftmovement), params: {rftmovement: {rx_weight: 115}}
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect when logged in as different user" do
    log_in_as(@user2)
    get edit_rft_rftmovement_path(@rft, @rftmovement)
    assert flash.empty?
    assert_redirected_to root_path
  end

  test "should redirect update when logged in as different user" do
    log_in_as(@user2)
    patch rft_rftmovement_path(@rft, @rftmovement), params: {rftmovement: {rx_weight: 115}}
    assert flash.empty?
    assert_redirected_to root_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Rftmovement.count' do
      delete rft_rftmovement_path(@rft, @rftmovement)
    end
    assert_redirected_to login_path
  end

  test "should redirect destroy when not logged in as different user" do
    log_in_as(@user2)
    assert_no_difference 'Rftmovement.count' do
      delete rft_rftmovement_path(@rft, @rftmovement)
    end
    assert_redirected_to root_path
  end
  end
