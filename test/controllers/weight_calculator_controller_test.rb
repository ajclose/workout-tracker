require 'test_helper'

class WeightCalculatorControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get weight_calculator_path
    assert_response :success
  end
end
