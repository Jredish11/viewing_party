require 'rails_helper'

RSpec.describe "User's Discover Movies page" do
  before(:each) do
    @user1 = User.create!(name: 'John Smith', email: 'jsmith@aol.com', password: 'password')

    visit user_discover_path(@user1)
  end

  it 'displays the users Discover Movies page' do
    expect(current_path).to eq("/users/#{@user1.id}/discover")
    expect(page).to have_content('Discover Movies')
  end

  it 'displays a button to Discover Top Rated Movies' do
    within('#discover-top-movies') do
      expect(page).to have_button('Find Top Rated Movies')

      click_button('Find Top Rated Movies')
      expect(current_path).to eq(user_movies_path(@user1))
    end
  end

  it 'displays a text field to enter keyword(s) to search by movie title' do
    within('#search-movies') do
      expect(page).to have_field(:title, type: 'text')
    end
  end

  it 'has a button to Search by Movie Title' do
    within('#search-movies') do
      expect(page).to have_button('Find Movies')

      fill_in :title, with: 'The Matrix'
      click_button('Find Movies')
      expect(current_path).to eq(user_movies_path(@user1))
    end
  end
end
