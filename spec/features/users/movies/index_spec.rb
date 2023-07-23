require 'rails_helper'

RSpec.describe "User's Movies page" do
  before(:each) do
    @user1 = User.create!(name: 'John Smith', email: 'xde@aol.com', password: 'password')
    @movie1 = MovieFacade.new({ type: 'top20rated' }).search.first
    @movie2 = MovieFacade.new({ title: 'Rebel Without a Cause' }).search.first
  end

  describe "when I choose to Discover Top Rated Movies" do
    it 'displays the 20 most popular movies and a link to their show pages' do
      visit user_discover_path(@user1)

      click_button('Find Top Rated Movies')
      expect(current_path).to eq(user_movies_path(@user1))

      within("#movie-#{@movie1.id}") do
        expect(page).to have_content(@movie1.title)
        expect(page).to have_link(@movie1.title)

        click_link(@movie1.title)
        expect(current_path).to eq(user_movie_path(@user1, @movie1.id))
      end
    end

    it 'displays the vote average of the movie' do
      visit user_discover_path(@user1)

      click_button('Find Top Rated Movies')
      expect(current_path).to eq(user_movies_path(@user1))

      within("#movie-#{@movie1.id}") do
        expect(page).to have_content(@movie1.vote_average)
      end
    end
  end

  describe "when I choose to search for a movie" do
    it 'displays the searched movies and a link to their show pages' do
      visit user_discover_path(@user1)

      fill_in :title, with: 'Rebel Without a Cause'
      click_button('Find Movies')
      expect(current_path).to eq(user_movies_path(@user1))

      within("#movie-#{@movie2.id}") do
        expect(page).to have_content(@movie2.title)
        expect(page).to have_link(@movie2.title)

        click_link(@movie2.title)
        expect(current_path).to eq(user_movie_path(@user1, @movie2.id))
      end
    end

    it 'displays the vote average of the movie' do
      visit user_discover_path(@user1)

      fill_in :title, with: 'Rebel Without a Cause'
      click_button('Find Movies')

      within("#movie-#{@movie2.id}") do
        expect(page).to have_content(@movie2.vote_average)
      end
    end

    it 'has a button to return to the Discover Movies page' do
      visit user_discover_path(@user1)

      fill_in :title, with: 'Rebel Without a Cause'
      click_button('Find Movies')

      expect(page).to have_button('Discover Page')
      click_button('Discover Page')
      expect(current_path).to eq(user_discover_path(@user1))
    end
  end
end
