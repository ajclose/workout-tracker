require 'test_helper'

class RftsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(email: "test@example.com", password: "password", password_confirmation: "password", admin: true, activated: true)
    @user2 = User.create(email: "test2@example.com", password: "password", password_confirmation: "password", activated: true)
    @workout = Workout.create(date: "2017-09-25", user_id: @user.id)
    @rft = Rft.create(rounds: 5, score: "11:20", workout_id: @workout.id)
  end

  test "should redirect edit page when not logged in" do
    get edit_workout_rft_path(@workout, @rft)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch workout_rft_path(@workout, @rft), params: {rft: {score: "11"}}
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as different user" do
    log_in_as(@user2)
    get edit_workout_rft_path(@workout, @rft)
    assert flash.empty?
    assert_redirected_to root_path
  end

  test "should redirect update when logged in as different user" do
    log_in_as(@user2)
    patch workout_rft_path(@workout, @rft), params: {rft: {score: "11"}}
    assert flash.empty?
    assert_redirected_to root_path
  end

  test "should redirect index page when not logged in" do
    get rfts_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect show page when not logged in" do
    get workout_rft_path(@workout, @rft)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect show when logged in as different user" do
    log_in_as(@user2)
    get workout_rft_path(@workout, @rft)
    assert flash.empty?
    assert_redirected_to root_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Rft.count' do
      delete workout_rft_path(@workout, @rft)
    end
    assert_redirected_to login_path
  end

  test "should redirect destroy when not logged in as different user" do
    log_in_as(@user2)
    assert_no_difference 'Rft.count' do
      delete workout_rft_path(@workout, @rft)
    end
    assert_redirected_to root_path
  end
end
