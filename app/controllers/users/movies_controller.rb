class Users::MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @movies = MovieFacade.new(params).search
  end

  def show
    @user = User.find(params[:user_id])
    @movie = MovieFacade.new(params).search
    if !current_user
      flash[:error] = "You must be logged in or registered user to create a viewing party"
    end
  end
end
