require 'test_helper'

class KicksControllerTest < ActionController::TestCase
  setup do
    @kick = kicks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kicks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kick" do
    assert_difference('Kick.count') do
      post :create, kick: { manufacturer: @kick.manufacturer, name: @kick.name, product_type: @kick.product_type }
    end

    assert_redirected_to kick_path(assigns(:kick))
  end

  test "should show kick" do
    get :show, id: @kick
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @kick
    assert_response :success
  end

  test "should update kick" do
    patch :update, id: @kick, kick: { manufacturer: @kick.manufacturer, name: @kick.name, product_type: @kick.product_type }
    assert_redirected_to kick_path(assigns(:kick))
  end

  test "should destroy kick" do
    assert_difference('Kick.count', -1) do
      delete :destroy, id: @kick
    end

    assert_redirected_to kicks_path
  end
end
