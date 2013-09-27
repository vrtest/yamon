class LoginController < ApplicationController

  before_filter :authorize, :only => [:add_user, :delete_user, :list_users]

  def add_user
    @user = User.new(params[:user])
    if request.post? and @user.save
      flash.now[:notice] = t('c_login.user_created0') + ' ' + @user.name + ' ' +t('c_login.user_created1')
      @user = User.new
    end
  end

  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = user.id
        redirect_to(:action => "index")
      else
        flash[:notice] = t('c_login.invalid_user_or_password')
      end
    end
  end

  def logout
    session[:user_id] = nil
  end

  def index
    if ! session[:user_id]
      redirect_to(:action => "login")
    end
  end

  def delete_user
  end

  def list_users
    @all_users = User.all
  end

end
