require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = User.create(name: "name", email: "user@example.com", password: "password")
    
    visit login_form_path

    fill_in :email, with: "user@example.com"
    fill_in :password, with: "password"
    
    click_on "Log In"

    expect(current_path).to eq(root_path)
  end

  it "cannot log in with bad credentials" do
    user = User.create(name: "name", email: "user@example.com", password: "password")
    
    visit login_form_path

    fill_in :email, with: user.email
    fill_in :password, with: "incorrect password"

    click_on "Log In"

    expect(current_path).to eq(login_form_path)
    expect(page).to have_content("Sorry invalid credentials")
  end

  it "clicks on link to go to dashboard, has to login, and fills out credentials incorrectly" do
    user1 = User.create!(name: 'John Smith', email: 'jsmith@aol.com', password: 'password')
    visit root_path

    click_link(user1.name)

    expect(current_path).to eq(login_form_path)

    fill_in :email, with: user1.email
    fill_in :password, with: "incorrect password"

    click_on "Log In"

    expect(current_path).to eq(login_form_path)
    expect(page).to have_content("Sorry invalid credentials")
  end
end