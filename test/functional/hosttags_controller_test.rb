require 'test_helper'

class HosttagsControllerTest < ActionController::TestCase

  fixtures :users #needed for auth

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hosttags)
  end

  test "should get new" do
    get :new, {}, { :user_id => users(:vincent).id }
    assert_response :success
  end

  test "should create hosttag" do
    assert_difference('Hosttag.count') do
      post :create, { :hosttag => { :name => "a tag" }}, { :user_id => users(:vincent).id }
    end

    assert_redirected_to hosttag_path(assigns(:hosttag))
  end

  test "should show hosttag" do
    get :show, :id => hosttags(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, { :id => hosttags(:one).to_param }, { :user_id => users(:vincent).id }
    assert_response :success
  end

  test "should update hosttag" do
    put :update, { :id => hosttags(:one).to_param, :hosttag => { :name => "another tag" } }, { :user_id => users(:vincent).id }
    assert_redirected_to hosttag_path(assigns(:hosttag))
  end

  test "should destroy hosttag" do
    assert_difference('Hosttag.count', -1) do
      delete :destroy, { :id => hosttags(:one).to_param }, { :user_id => users(:vincent).id }
    end

    assert_redirected_to hosttags_path
  end
end
