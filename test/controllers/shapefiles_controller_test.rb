require 'test_helper'

class ShapefilesControllerTest < ActionController::TestCase
  setup do
    @shapefile = shapefiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shapefiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shapefile" do
    assert_difference('Shapefile.count') do
      post :create, shapefile: { description: @shapefile.description, name: @shapefile.name, shapefile: @shapefile.shapefile }
    end

    assert_redirected_to shapefile_path(assigns(:shapefile))
  end

  test "should show shapefile" do
    get :show, id: @shapefile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shapefile
    assert_response :success
  end

  test "should update shapefile" do
    patch :update, id: @shapefile, shapefile: { description: @shapefile.description, name: @shapefile.name, shapefile: @shapefile.shapefile }
    assert_redirected_to shapefile_path(assigns(:shapefile))
  end

  test "should destroy shapefile" do
    assert_difference('Shapefile.count', -1) do
      delete :destroy, id: @shapefile
    end

    assert_redirected_to shapefiles_path
  end
end
