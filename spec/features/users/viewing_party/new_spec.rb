require 'rails_helper'

RSpec.describe "User's Viewing Party page" do
  before(:each) do
    @user1 = User.create!(name: 'John Smith', email: 'jsmith@aol.com', password: 'password')
    @user2 = User.create!(name: 'Emily Jones', email: '343ftl.com', password: 'password')
    @user3 = User.create!(name: 'Jimmy johnson', email: 'jj33@aol.com', password: 'password')
    @user4 = User.create!(name: 'Todd Guy', email: 'tg@gmail.com', password: 'password')
    visit login_form_path
        
    fill_in :email, with: "jsmfith@aol.com"
    fill_in :password, with: "password"
    
    click_on "Log In"
    

    visit  user_viewing_party_path(@user1, 238)
  end

  it 'displays the movie title' do
    expect(page).to have_content('The Godfather')
  end

  it 'has a button to Discover Page' do
    expect(page).to have_button('Discover Page')
  end

  it 'has a field for party duration that defaults to movie runtime' do
    expect(page).to have_field('duration', with: 175)
  end

  it 'has a field for party date' do
    expect(page).to have_field('date')
  end

  it 'has a field for party start time' do
    expect(page).to have_field('start_time')
  end

  it 'has checkboxes for all other existing users' do
    expect(page).to have_field('selected_users[]', with: @user2.id)
    expect(page).to have_field('selected_users[]', with: @user3.id)
    expect(page).to have_field('selected_users[]', with: @user4.id)
    expect(page).to_not have_field('selected_users[]', with: @user1.id)
  end

  it 'has a button to create a party' do
    expect(page).to have_button('Create Party')
  end

  it 'redirects the user back to dashboard when Party is created' do
    fill_in 'duration', with: 210
    fill_in 'date', with: "2024-01-01"
    fill_in 'start_time', with: "07:00"
    check("selected_users[]", option: @user2.id)
    check("selected_users[]", option: @user3.id)
    click_button('Create Party')

    expect(current_path).to eq(user_path(@user1))
  end

  it 'does not create a party if duration is less than the movie runtime' do
    fill_in 'duration', with: 10
    fill_in 'date', with: "2024-01-01"
    fill_in 'start_time', with: "07:00"
    check("selected_users[]", option: @user2.id)
    check("selected_users[]", option: @user3.id)
    click_button('Create Party')

    expect(current_path).to eq(user_viewing_party_path(@user1, 238))
    expect(page).to have_content("Party duration cannot be less than movie runtime")
  end

  it 'does not create a party if any field is empty' do
    fill_in 'duration', with: ""
    fill_in 'date', with: "2024-01-01"
    fill_in 'start_time', with: "07:00"
    check("selected_users[]", option: @user2.id)
    check("selected_users[]", option: @user3.id)
    click_button('Create Party')

    expect(current_path).to eq(user_viewing_party_path(@user1, 238))
    expect(page).to have_content("Duration can't be blank")
  end

  it 'does not create a party if no user is selected' do
    fill_in 'duration', with: 300
    fill_in 'date', with: "2024-01-01"
    fill_in 'start_time', with: "07:00"
    click_button('Create Party')

    expect(current_path).to eq(user_viewing_party_path(@user1, 238))
    expect(page).to have_content("Please select at least one user")
  end
end
