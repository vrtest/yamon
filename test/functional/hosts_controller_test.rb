require 'test_helper'
require 'pp'

class HostsControllerTest < ActionController::TestCase

  fixtures :users #needed for auth

  test "should be auth" do
    get :new
    assert_redirected_to :controller => "login", :action => "login"

    assert_no_difference('Host.count') do
      post :create, :host => { :name => 'hosttest01' }
    end

#    p @response


    assert_no_difference('Host.count', -1) do
      delete :destroy, { :id => hosts(:one).to_param }
    end

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hosts)
  end

  test "should get new" do
    get :new, {}, { :user_id => users(:vincent).id }
    assert_response :success
  end

  test "should create host" do
    assert_difference('Host.count') do
      post :create, {:host => { :name => 'hosttest01' }}, { :user_id => users(:vincent).id }
    end
    assert_redirected_to host_path(assigns(:host))
  end

  test "should show host" do
    get :show, :id => hosts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, { :id => hosts(:one).to_param }, { :user_id => users(:vincent).id }
    assert_response :success
  end

  test "should update host" do
    put :update, { :id => hosts(:one).to_param, :host => { :name => 'hosttest01-2' }}, { :user_id => users(:vincent).id }
    assert_redirected_to host_path(assigns(:host))
  end

  test "should destroy host" do
    assert_difference('Host.count', -1) do
      delete :destroy, { :id => hosts(:one).to_param }, { :user_id => users(:vincent).id }
    end

    assert_redirected_to hosts_path
  end
end
