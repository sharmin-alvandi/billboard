class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  # before_action :set_user, only: [:show, :edit, :update, :destroy]
  # respond_to :html, :json

  # def index
  #   @users = User.all
  # end

  def new
    @user = User.new
  end

  def create
    # respond_to :html, :json
    @user = User.new(user_params) 
    respond_to do |format|
      if @user.save
        username = user_params[:username]
        # if User.username_not_exists?(username: username)
          # if @user.save 
            session[:user_id] = @user.id 
            
            # In the real world project I'm going to retrieve the store name and id using 'shops' Shopify API. 
            # In that case there is no need to create a table for the stores as well as users. And also users do not sign up using this app.
            # I only added these processes to show the workflow and practice what I learnt in Rails.
            Store.create(:title => @user.username, :user_id => @user.id)
            format.html { redirect_to advertisements_url, notice: 'You signed up and logged in successfully' }
          # else
          #   format.html { redirect_to new_user_url, notice: 'Something went wrong. Please try again.' }
          # end
        # else
        #   redirect_to users_new_url, notice: 'The user name already exists.'
        # end
      else
        format.html { render 'new' }
        # redirect_to users_new_url(@user), :flash => { :error => @user.errors.full_messages.join(', ') }
      end
    end
  end

  # def destroy
  #   @user.destroy
  #   respond_to do |format|
  #     format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  # def set_user
  #   @user = User.find(params[:id])
  # end

  private
    def user_params
      params.require(:user).permit(:username, :password);
    end
end
