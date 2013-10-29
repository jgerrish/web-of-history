require 'test_helper'

class HistoricalSourcesControllerTest < ActionController::TestCase
  setup do
    @historical_source = historical_sources(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:historical_sources)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create historical_source" do
    assert_difference('HistoricalSource.count') do
      post :create, historical_source: { name: @historical_source.name, subject: @historical_source.subject }
    end

    assert_redirected_to historical_source_path(assigns(:historical_source))
  end

  test "should show historical_source" do
    get :show, id: @historical_source
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @historical_source
    assert_response :success
  end

  test "should update historical_source" do
    patch :update, id: @historical_source, historical_source: { name: @historical_source.name, subject: @historical_source.subject }
    assert_redirected_to historical_source_path(assigns(:historical_source))
  end

  test "should destroy historical_source" do
    assert_difference('HistoricalSource.count', -1) do
      delete :destroy, id: @historical_source
    end

    assert_redirected_to historical_sources_path
  end
end
