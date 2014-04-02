require 'test_helper'

class HistoricalLocationsControllerTest < ActionController::TestCase
  setup do
    @historical_location = historical_locations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:historical_locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create historical_location" do
    assert_difference('HistoricalLocation.count') do
      post :create, historical_location: { lat: @historical_location.lat, lon: @historical_location.lon, name: @historical_location.name }
    end

    assert_redirected_to historical_location_path(assigns(:historical_location))
  end

  test "should show historical_location" do
    get :show, id: @historical_location
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @historical_location
    assert_response :success
  end

  test "should update historical_location" do
    patch :update, id: @historical_location, historical_location: { lat: @historical_location.lat, lon: @historical_location.lon, name: @historical_location.name }
    assert_redirected_to historical_location_path(assigns(:historical_location))
  end

  test "should destroy historical_location" do
    assert_difference('HistoricalLocation.count', -1) do
      delete :destroy, id: @historical_location
    end

    assert_redirected_to historical_locations_path
  end
end
