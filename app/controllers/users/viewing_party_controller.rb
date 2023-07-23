class Users::ViewingPartyController < ApplicationController
  def new
      @movie = MovieFacade.new(params).search
      @user = User.find(params[:user_id])
      @users = User.where.not(id: @user.id)
  end

  def create
    user = User.find(params[:user_id])
    party = Party.new(party_params)
  movie = MovieService.new.search_movies_by_id(params[:movie_id])
    if party.save && !params[:selected_users].nil? && movie[:runtime] <= party.duration
      PartyUser.create(user_id: user.id , party_id: party.id)

      params[:selected_users].each do |user_id|
        PartyUser.create(user_id: user_id, party_id: party.id)
      end
      redirect_to user_path(user)
    elsif params[:selected_users].nil? 
      flash[:notice] = "Please select at least one user"
      redirect_to user_viewing_party_path(user, params[:movie_id])
    elsif !params[:duration].empty? && party.duration < movie[:runtime]
      flash[:notice] = "Party duration cannot be less than movie runtime"
      redirect_to user_viewing_party_path(user, params[:movie_id])
    else
      flash[:notice] = party.errors.full_messages.to_sentence
      redirect_to user_viewing_party_path(user, params[:movie_id])
    end
  end 


  private

  def party_params
    params[:host_id] = params[:user_id]
    params.permit(:date, :start_time, :duration, :movie_id, :host_id)
  end

  
end