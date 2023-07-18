require 'rails_helper'

RSpec.describe 'User registration page' do
  before(:each) do
    visit register_path
  end

  it 'displays a new user registration form' do
    expect(page).to have_content('Register New User')
    expect(page).to have_field('name')
    expect(page).to have_field('email')
    expect(page).to have_button('Register as a User')
  end

  it 'registers a new user' do
    
    name = "funbucket13"
    email = "funbucket13@gmail.com"
    password = "test"
    
    fill_in :name, with: name
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password
    
    
    click_on "Register as a User"

    user= User.last
    
    expect(current_path).to eq(user_path(user))
  end

  it 'displays an error if form is incomplete' do
    fill_in 'email', with: 'jadams6@gmail.com'
    click_button "Register as a User"

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Name can't be blank")
  end
end
