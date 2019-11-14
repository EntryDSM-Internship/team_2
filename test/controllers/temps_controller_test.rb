require 'test_helper'

class TempsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @temp = temps(:one)
  end

  test "should get index" do
    get temps_url, as: :json
    assert_response :success
  end

  test "should create temp" do
    assert_difference('Temp.count') do
      post temps_url, params: { temp: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show temp" do
    get temp_url(@temp), as: :json
    assert_response :success
  end

  test "should update temp" do
    patch temp_url(@temp), params: { temp: {  } }, as: :json
    assert_response 200
  end

  test "should destroy temp" do
    assert_difference('Temp.count', -1) do
      delete temp_url(@temp), as: :json
    end

    assert_response 204
  end
end
