require 'test_helper'

class ServicesControllerTest < ActionController::TestCase

  fixtures :users #needed for auth

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:services)
  end

  test "should get new" do
    get :new, {}, { :user_id => users(:vincent).id }
    assert_response :success
  end

  test "should create service" do
    assert_difference('Service.count') do
      post :create, { :service => { :host_id => "1", :name => "a service" } }, { :user_id => users(:vincent).id }
    end

    assert_redirected_to service_path(assigns(:service))
  end

  test "should show service" do
    get :show, :id => services(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, { :id => services(:one).to_param }, { :user_id => users(:vincent).id }
    assert_response :success
  end

  test "should update service" do
    put :update, { :id => services(:one).to_param, :service => { :name => "another name" } }, { :user_id => users(:vincent).id }
    assert_redirected_to service_path(assigns(:service))
  end

  test "should destroy service" do
    assert_difference('Service.count', -1) do
      delete :destroy, { :id => services(:one).to_param }, { :user_id => users(:vincent).id }
    end

    assert_redirected_to services_path
  end
end
