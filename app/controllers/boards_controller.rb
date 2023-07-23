class BoardsController < ApplicationController
  def index
    if !current_user
      redirect_to root_path
      flash[:error] = "You must be logged in or registered to access your dashboard"
    else
      flash[:success] = "Welcome, #{current_user.name}"
    end
  end
end