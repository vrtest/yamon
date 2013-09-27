require 'test_helper'

class ServicetagsControllerTest < ActionController::TestCase

  fixtures :users #needed for auth

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:servicetags)
  end

  test "should get new" do
    get :new, {}, { :user_id => users(:vincent).id }
    assert_response :success
  end

  test "should create servicetag" do
    assert_difference('Servicetag.count') do
      post :create, { :servicetag => { :name => "a tag" }}, { :user_id => users(:vincent).id }
    end

    assert_redirected_to servicetag_path(assigns(:servicetag))
  end

  test "should show servicetag" do
    get :show, :id => servicetags(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, { :id => servicetags(:one).to_param }, { :user_id => users(:vincent).id }
    assert_response :success
  end

  test "should update servicetag" do
    put :update, { :id => servicetags(:one).to_param, :servicetag => { :name => "another tag" } }, { :user_id => users(:vincent).id }
    assert_redirected_to servicetag_path(assigns(:servicetag))
  end

  test "should destroy servicetag" do
    assert_difference('Servicetag.count', -1) do
      delete :destroy, { :id => servicetags(:one).to_param }, { :user_id => users(:vincent).id }
    end

    assert_redirected_to servicetags_path
  end
end
