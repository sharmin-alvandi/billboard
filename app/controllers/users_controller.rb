class UsersController < ApplicationController

  skip_before_action :authorized, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params) 
    if @user.save 
      session[:user_id] = @user.id 
    # @user = User.create(params.require(:user).permit(:username,        
  #  :password))
  #  session[:user_id] = @user.id
     redirect_to advertisements_url, notice: 'You signed up successfully'
    else
      redirect_to sessions_welcome_url, notice: 'Something went wrong. Please try again.'
    end
  end

  private
    def user_params

      params.require(:user).permit(:username, :password);
    end

end
