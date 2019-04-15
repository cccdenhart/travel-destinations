class SessionsController < ApplicationController

  before_action :authenticate_user, :except => [:index, :login, :login_attempt, :logout]
  before_action :save_login_state, :only => [:index, :login, :login_attempt]
  def login
  end

  def home
  end

  def profile
  end

  def setting
  end

  def login_attempt
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome again, you logged in as #{user.username}"
      redirect_to(:action => 'home')
    else
      flash[:notice] = "Invalid Username or Password"
      flash[:color]= "invalid"
      render "login"
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = 'Successfully Logged Out'
    redirect_to :action => 'login'
  end
end
