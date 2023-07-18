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

  it 'displays an error if form name field is empty' do
    fill_in 'email', with: 'jadams6@gmail.com'
    click_button "Register as a User"
    

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Name can't be blank")
  end
  
  it 'displays an error if form email field is empty' do
    name = "funbucket13"
    email = ""
    password = "test"
    
    fill_in :name, with: name
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password
    click_button "Register as a User"
    

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email can't be blank")
  end

  it 'displays an error if form password field is empty' do
    name = "funbucket13"
    email = "jsmith@aol.com"
    password = ""
    
    fill_in :name, with: name
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password
    click_button "Register as a User"
    

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Password digest can't be blank and Password can't be blank")
  end

  it 'displays an error if password does not match' do
    name = "funbucket13"
    email = "jsmith@aol.com"
    password = "test"
    
    fill_in :name, with: name
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: 'jim'
    click_button "Register as a User"
    

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  it "displays an error if email is not unique" do
    user1 = User.create!(name: "jim", email: "jim@aol.com", password: "turing", password_confirmation: "turing")

    fill_in :name, with: "James"
    fill_in :email, with: "jim@aol.com"
    fill_in :password, with: "beans"
    fill_in :password_confirmation, with: "beans"

    click_button "Register as a User"

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email has already been taken")
  end
  
  it "displays an error if all fields of form left blank" do
    fill_in :name, with: ""
    fill_in :email, with: ""
    fill_in :password, with: ""
    fill_in :password_confirmation, with: ""

    click_button "Register as a User"

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Name can't be blank, Email can't be blank, Password digest can't be blank, and Password can't be blank")
  end
end
