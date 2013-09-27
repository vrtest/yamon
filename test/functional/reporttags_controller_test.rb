require 'test_helper'

class ReporttagsControllerTest < ActionController::TestCase

  fixtures :users #needed for auth

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reporttags)
  end

  test "should get new" do
    get :new, {}, { :user_id => users(:vincent).id }
    assert_response :success
  end

  test "should create reporttag" do
    assert_difference('Reporttag.count') do
      post :create, { :reporttag => { :name => "a tag" }}, { :user_id => users(:vincent).id }
    end

    assert_redirected_to reporttag_path(assigns(:reporttag))
  end

  test "should show reporttag" do
    get :show, :id => reporttags(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, { :id => reporttags(:one).to_param }, { :user_id => users(:vincent).id }
    assert_response :success
  end

  test "should update reporttag" do
    put :update, { :id => reporttags(:one).to_param, :reporttag => { :name => "another tag" } }, { :user_id => users(:vincent).id }
    assert_redirected_to reporttag_path(assigns(:reporttag))
  end

  test "should destroy reporttag" do
    assert_difference('Reporttag.count', -1) do
      delete :destroy, { :id => reporttags(:one).to_param }, { :user_id => users(:vincent).id }
    end

    assert_redirected_to reporttags_path
  end
end
