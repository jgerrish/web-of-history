require 'test_helper'

class EventGroupsControllerTest < ActionController::TestCase
  setup do
    @event_group = event_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event_group" do
    assert_difference('EventGroup.count') do
      post :create, event_group: { name: @event_group.name }
    end

    assert_redirected_to event_group_path(assigns(:event_group))
  end

  test "should show event_group" do
    get :show, id: @event_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event_group
    assert_response :success
  end

  test "should update event_group" do
    patch :update, id: @event_group, event_group: { name: @event_group.name }
    assert_redirected_to event_group_path(assigns(:event_group))
  end

  test "should destroy event_group" do
    assert_difference('EventGroup.count', -1) do
      delete :destroy, id: @event_group
    end

    assert_redirected_to event_groups_path
  end
end
