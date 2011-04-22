require 'test_helper'

class DropoffsControllerTest < ActionController::TestCase
  setup do
    @dropoff = dropoffs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dropoffs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dropoff" do
    assert_difference('Dropoff.count') do
      post :create, :dropoff => @dropoff.attributes
    end

    assert_redirected_to dropoff_path(assigns(:dropoff))
  end

  test "should show dropoff" do
    get :show, :id => @dropoff.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @dropoff.to_param
    assert_response :success
  end

  test "should update dropoff" do
    put :update, :id => @dropoff.to_param, :dropoff => @dropoff.attributes
    assert_redirected_to dropoff_path(assigns(:dropoff))
  end

  test "should destroy dropoff" do
    assert_difference('Dropoff.count', -1) do
      delete :destroy, :id => @dropoff.to_param
    end

    assert_redirected_to dropoffs_path
  end
end
