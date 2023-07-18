class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      redirect_to register_path
      flash[:notice] = @user.errors.full_messages.to_sentence
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def login_form

  end

  def login_user
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      flash[:success] = "Welcome, #{user.email}!"
      redirect_to root_path
    else
      flash[:error] = "Sorry invalid credentials"
      render :login_form
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
