class UsersController < ApplicationController
  def new
  end

  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     session[:user_id] = @user.id
  #     redirect_to user_path(@user)
  #   else
  #     redirect_to register_path
  #     flash[:notice] = @user.errors.full_messages.to_sentence
  #   end
  # end

  def show
    @user = User.find(params[:id])
  end

  # def login_form

  # end

  # def login_user
  #   user = User.find_by(email: params[:email])
  #   if user && user.authenticate(params[:password])
  #     session[:user_id] = user.id
  #     flash[:success] = "Welcome, #{user.email}!"
  #     redirect_to root_path
  #   else
  #     redirect_to login_form_path
  #     flash[:error] = "Sorry invalid credentials"
  #   end
  # end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
