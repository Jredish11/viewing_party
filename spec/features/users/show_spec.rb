require 'rails_helper'

RSpec.describe 'User Dashboard page' do
  before(:each) do
    @user1 = User.create!(name: 'John Smith', email: 'jsmith@aol.com', password: 'password')
    @user2 = User.create!(name: 'Emily Jones', email: '343ftl.com', password: 'password')
    @user3 = User.create!(name: 'Jimmy johnson', email: 'jj33@aol.com', password: 'password')
    @user4 = User.create!(name: 'Todd Guy', email: 'tg@gmail.com', password: 'password')
  end

  it 'displays the users Dashboard' do
    visit user_path(@user1)

    within('#header') do
      expect(page).to have_content("#{@user1.name}'s Dashboard")
      expect(page).to_not have_content(@user2.name)
    end
  end

  it 'displays a button to Discover Movies' do
    visit user_path(@user1)

    expect(page).to have_button('Discover Movies')
  end

  it 'redirects to the Discover Movies page when the Discover Movies button is clicked' do
    visit user_path(@user1)

    click_button('Discover Movies')
    expect(current_path).to eq("/users/#{@user1.id}/discover")
  end

  it 'displays new event on users dashboard' do
    visit user_viewing_party_path(@user1, 238)

    fill_in 'duration', with: 210
    fill_in 'date', with: "2024-01-01"
    fill_in 'start_time', with: "07:00"
    check("selected_users[]", option: @user2.id)
    check("selected_users[]", option: @user3.id)
    click_button('Create Party')

    expect(current_path).to eq(user_path(@user1))
    expect(page).to have_content("The Godfather")
  end

  it 'displays events on other invited users dashboards' do
    visit user_viewing_party_path(@user1, 238)

    fill_in 'duration', with: 210
    fill_in 'date', with: "2024-01-01"
    fill_in 'start_time', with: "07:00"
    check("selected_users[]", option: @user2.id)
    check("selected_users[]", option: @user3.id)
    click_button('Create Party')

    visit user_path(@user2)
    expect(page).to have_content("The Godfather")

    visit user_path(@user3)
    expect(page).to have_content("The Godfather")

    visit user_path(@user4)
    expect(page).to_not have_content("The Godfather")
  end

  describe 'Viewing Parties that the user has been invited to' do
    before(:each) do
      visit user_viewing_party_path(@user1, 238)

      fill_in 'duration', with: 210
      fill_in 'date', with: "2024-01-01"
      fill_in 'start_time', with: "07:00"
      check("selected_users[]", option: @user2.id)
      check("selected_users[]", option: @user3.id)
      click_button('Create Party')
      visit user_path(@user2)
    end

    it 'displays movie title, which links to the movie show page' do
      within('#invited-parties') do
        expect(page).to have_link('The Godfather', href: user_movie_path(@user1, 238))
        click_link('The Godfather')
        expect(current_path).to eq(user_movie_path(@user1, 238))
      end
    end

    it 'displays date and time of the event' do
      within('#invited-parties') do
        expect(page).to have_content("January 1, 2024")
        expect(page).to have_content("07:00 AM")
      end
    end

    it 'displays who is hosting the event' do
      within('#invited-parties') do
        expect(page).to have_content("Host: #{@user1.name}")
      end
    end

    it 'displays list of invited users with my name in bold' do
      within('#invited-parties') do
        expect(page).to have_css('strong', text: @user2.name)
        expect(page).to have_content(@user1.name)
        expect(page).to have_content(@user3.name)
        expect(page).to_not have_content(@user4.name)
      end
    end
  end

  describe 'Viewing Parties that the user has created' do
    before(:each) do
      visit user_viewing_party_path(@user1, 238)

      fill_in 'duration', with: 210
      fill_in 'date', with: "2024-01-01"
      fill_in 'start_time', with: "07:00"
      check("selected_users[]", option: @user2.id)
      check("selected_users[]", option: @user3.id)
      click_button('Create Party')
    end

    it 'displays movie title, which links to the movie show page' do
      within('#hosted-parties') do
        expect(page).to have_link('The Godfather', href: user_movie_path(@user1, 238))
        click_link('The Godfather')
        expect(current_path).to eq(user_movie_path(@user1, 238))
      end
    end

    it 'displays date and time of the event' do
      within('#hosted-parties') do
        expect(page).to have_content("January 1, 2024")
        expect(page).to have_content("07:00 AM")
      end
    end

    it 'displays who is hosting the event' do
      within('#hosted-parties') do
        expect(page).to have_content("Host: #{@user1.name}")
      end
    end

    it 'displays list of invited users' do
      within('#hosted-parties') do
        within('#guests') do
          expect(page).to_not have_content(@user1.name)
          expect(page).to have_content(@user2.name)
          expect(page).to have_content(@user3.name)
          expect(page).to_not have_content(@user4.name)
        end
      end
    end
  end
end
