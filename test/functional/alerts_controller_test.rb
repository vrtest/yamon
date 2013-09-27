require 'test_helper'

class AlertsControllerTest < ActionController::TestCase

  fixtures :users #needed for auth
  fixtures :alerts

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alerts)
  end

  test "should get new" do
    get :new, {}, { :user_id => users(:vincent).id }
    assert_response :success
  end

  test "should create alert" do
    assert_difference('Alert.count') do
      tnow = Time.now
      post :create, { :alert => { :service_id => "1", :check_status => "2", :duration => "60", :host_id => "1",
                       :date_start => tnow.strftime("%Y-%m-%d %H:%M:%S"),
                       :date_end => (tnow + 60).strftime("%Y-%m-%d %H:%M:%S") 
                    }},
                    { :user_id => users(:vincent).id }
    end

    assert_redirected_to alert_path(assigns(:alert))
  end

  test "should show alert" do
    get :show, { :id => alerts(:one).to_param }, { :user_id => users(:vincent).id }
    assert_response :success
  end

  test "should get edit" do
    get :edit, { :id => alerts(:one).to_param }, { :user_id => users(:vincent).id }
    assert_response :success
  end

  test "should update alert" do
    put :update, { :id => alerts(:one).to_param, :alert => { :service_output => "error 2" } }, { :user_id => users(:vincent).id }
    assert_redirected_to alert_path(assigns(:alert))
  end

  test "should destroy alert" do
    assert_difference('Alert.count', -1) do
      delete :destroy, { :id => alerts(:one).to_param }, { :user_id => users(:vincent).id }
    end

    assert_redirected_to alerts_path
  end
end
