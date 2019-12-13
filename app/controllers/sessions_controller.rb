class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create, :welcome]

  def new
  end

  def create
    @user = User.find_by(username: params[:username])
   if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to advertisements_url
   else
      redirect_to login_url, notice: 'Login failed. Please try again.'
   end
  end

  def login
  end

  def destroy
    session[:user_id] = nil
    redirect_to billboard_index_url, notice: 'You logged out successfully!'
  end
end
