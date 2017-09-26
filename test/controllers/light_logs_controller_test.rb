require 'test_helper'

class LightLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @light_log = light_logs(:one)
  end

  test "should get index" do
    get light_logs_url, as: :json
    assert_response :success
  end

  test "should create light_log" do
    assert_difference('LightLog.count') do
      post light_logs_url, params: { light_log: { event: @light_log.event, light_id: @light_log.light_id } }, as: :json
    end

    assert_response 201
  end

  test "should show light_log" do
    get light_log_url(@light_log), as: :json
    assert_response :success
  end

  test "should update light_log" do
    patch light_log_url(@light_log), params: { light_log: { event: @light_log.event, light_id: @light_log.light_id } }, as: :json
    assert_response 200
  end

  test "should destroy light_log" do
    assert_difference('LightLog.count', -1) do
      delete light_log_url(@light_log), as: :json
    end

    assert_response 204
  end
end
