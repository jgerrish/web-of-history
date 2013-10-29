require 'test_helper'

class HistoricalEventsControllerTest < ActionController::TestCase
  setup do
    @historical_event = historical_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:historical_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create historical_event" do
    assert_difference('HistoricalEvent.count') do
      post :create, historical_event: { date_precision: @historical_event.date_precision, description: @historical_event.description, event_end_date: @historical_event.event_end_date, event_start_date: @historical_event.event_start_date, historical_source_id: @historical_event.historical_source_id, lat: @historical_event.lat, lon: @historical_event.lon, title: @historical_event.title }
    end

    assert_redirected_to historical_event_path(assigns(:historical_event))
  end

  test "should show historical_event" do
    get :show, id: @historical_event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @historical_event
    assert_response :success
  end

  test "should update historical_event" do
    patch :update, id: @historical_event, historical_event: { date_precision: @historical_event.date_precision, description: @historical_event.description, event_end_date: @historical_event.event_end_date, event_start_date: @historical_event.event_start_date, historical_source_id: @historical_event.historical_source_id, lat: @historical_event.lat, lon: @historical_event.lon, title: @historical_event.title }
    assert_redirected_to historical_event_path(assigns(:historical_event))
  end

  test "should destroy historical_event" do
    assert_difference('HistoricalEvent.count', -1) do
      delete :destroy, id: @historical_event
    end

    assert_redirected_to historical_events_path
  end
end
