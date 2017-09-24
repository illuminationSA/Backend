require 'test_helper'

class ScheduleTimesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @schedule_time = schedule_times(:one)
  end

  test "should get index" do
    get schedule_times_url, as: :json
    assert_response :success
  end

  test "should create schedule_time" do
    assert_difference('ScheduleTime.count') do
      post schedule_times_url, params: { schedule_time: { event_time: @schedule_time.event_time, light_id: @schedule_time.light_id, set_to: @schedule_time.set_to } }, as: :json
    end

    assert_response 201
  end

  test "should show schedule_time" do
    get schedule_time_url(@schedule_time), as: :json
    assert_response :success
  end

  test "should update schedule_time" do
    patch schedule_time_url(@schedule_time), params: { schedule_time: { event_time: @schedule_time.event_time, light_id: @schedule_time.light_id, set_to: @schedule_time.set_to } }, as: :json
    assert_response 200
  end

  test "should destroy schedule_time" do
    assert_difference('ScheduleTime.count', -1) do
      delete schedule_time_url(@schedule_time), as: :json
    end

    assert_response 204
  end
end
