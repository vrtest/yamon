require 'test_helper'

class LoginControllerTest < ActionController::TestCase

  fixtures :users

  def test_index
    get :index
    assert_redirected_to :controller => "login", :action => "login"
  end

  def test_index_with_user
    get :index, {}, { :user_id => users(:vincent).id }
    assert_response :success
    assert_template "index"
  end

  def test_add_user
    get :add_user
    assert_redirected_to :controller => "login", :action => "login"
  end

  def test_login
    v = users(:vincent)
    post :login, :name => v.name, :password => 'secret'
    assert_redirected_to :action => "index"
    assert_equal v.id, session[:user_id]
  end

  def test_bad_password
    v = users(:vincent)
    post :login, :name => v.name, :password => 'badsecret'
    assert_template "login"
    assert_not_equal v.id, session[:user_id]
  end

end
