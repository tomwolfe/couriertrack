require 'test_helper'

class CourierSessionsControllerTest < ActionController::TestCase
  setup do
    @courier_session = courier_sessions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:courier_sessions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create courier_session" do
    assert_difference('CourierSession.count') do
      post :create, :courier_session => @courier_session.attributes
    end

    assert_redirected_to courier_session_path(assigns(:courier_session))
  end

  test "should show courier_session" do
    get :show, :id => @courier_session.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @courier_session.to_param
    assert_response :success
  end

  test "should update courier_session" do
    put :update, :id => @courier_session.to_param, :courier_session => @courier_session.attributes
    assert_redirected_to courier_session_path(assigns(:courier_session))
  end

  test "should destroy courier_session" do
    assert_difference('CourierSession.count', -1) do
      delete :destroy, :id => @courier_session.to_param
    end

    assert_redirected_to courier_sessions_path
  end
end
