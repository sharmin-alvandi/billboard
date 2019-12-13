class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def new
    if !logged_in?
      @user = User.new
    else
      redirect_to advertisements_url
    end
  end

  def create
    @user = User.new(user_params) 
    respond_to do |format|
      if @user.save
        username = user_params[:username]
            session[:user_id] = @user.id 
            # In the real world project I'm going to retrieve the store name and id using 'shops' Shopify API. 
            # In that case there is no need to create a table for the stores, collections as well as users. And also users do not sign up using this app.
            # I only added these processes to show the workflow and practice what I learnt in Rails.
            Store.create(:title => @user.username, :user_id => @user.id)
            format.html { redirect_to advertisements_url, notice: 'You signed up and logged in successfully' }
      else
        format.html { render 'new' }
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :password);
    end
end
