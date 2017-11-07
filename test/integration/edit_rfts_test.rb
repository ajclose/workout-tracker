require 'test_helper'

class RftsEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(email: "test@example.com", password: "password", password_confirmation: "password", activated: true)
    @workout = Workout.create(date: "2017-09-25", user_id: @user.id)
    @rft = Rft.create!(rounds: 10, score: "10:50", workout_id: @workout.id)
  end

  test "missing rounds" do
    log_in_as(@user)
    get edit_workout_rft_path(@workout, @rft)
    assert_template 'rfts/edit'
    patch workout_rft_path(@workout, @rft), params: {rft: {rounds: ''}}
    assert_template 'rfts/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_workout_rft_path(@workout, @rft)
    assert_template 'rfts/edit'
    rounds = 11
    notes = "These are the updated notes!"
    name = "Fran"
    patch workout_rft_path(@workout, @rft), params: {rft: {rounds: rounds, notes: notes, name: name}}
    assert_not flash.empty?
    assert_redirected_to edit_workout_rft_path(@workout, @rft)
    @rft.reload
    assert_equal rounds, @rft.rounds
    assert_equal notes, @rft.notes
    assert_equal name, @rft.name
  end

end
