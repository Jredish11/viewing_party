require 'rails_helper'

RSpec.describe 'Landing Page' do
  describe "Welcome page" do
    before(:each) do
      @user1 = User.create!(name: 'John Smith', email: 'ith@aol.com', password: 'password')
      @user2 = User.create!(name: 'Jane Doe', email: 'jdoe@gmail.com', password: 'password')
      @user3 = User.create!(name: 'Michael Jackson', email: 'mjack@gmail.com', password: 'password')

      visit root_path
    end
    
    it 'displays the title of the application' do
      within('#title') do
        expect(page).to have_content('Viewing Party')
      end
    end
    
    it 'displays a button to create a new user' do
      within('#create-user') do
        expect(page).to have_button('Create User')
      end
    end
    
    it 'displays a list of existing users which links to the users dashboard' do
      within('#existing-users') do
        expect(page).to have_content('Existing Users')
        expect(page).to have_link(@user1.name)
        expect(page).to have_link(@user2.name)
        expect(page).to have_link(@user3.name)
      end
    end
    
    it 'displays a link to go back to the landing page' do
      within('#nav-bar') do
        expect(page).to have_link('Home')
        
        click_link('Home')
        expect(current_path).to eq(root_path)
      end
    end
    
    it 'displays a link for log in' do
      within('#log-in-link') do
        expect(page).to have_link('Log-in form')
        
        click_link('Log-in form')
        expect(current_path).to eq(login_form_path)
      end
    end
    
    it 'when a user link is clicked it take user to login page' do
      save_and_open_page
      click_link(@user1.name)
      
      expect(current_path).to eq(login_form_path)
    end
  end
    
  describe "Landing page as a logged in user" do
    before(:each) do
      @user = User.create(name: "name", email: "user@example.com", password: "password")
      
      visit login_form_path
      
      fill_in :email, with: "user@example.com"
      fill_in :password, with: "password"
      
      click_on "Log In"
      
      expect(current_path).to eq(root_path)
    end
    
    it "will not render link to login or create an account" do
      expect(page).to_not have_link("Log-in form")
      expect(page).to_not have_button("Create User")
    end
    
    it "will render a link to Log Out" do
      expect(page).to have_link("Log Out")
    end
    
    it "redirects back to landing page when click on Log out, rendering Log In link" do
      click_link("Log Out")
      expect(current_path).to eq(root_path)
      expect(page).to_not have_link("Log Out")
      expect(page).to have_button("Create User")
      expect(page).to have_content("Log-in form")
    end

    it "lists existing users email addresses" do
      user2 = User.create!(name: 'Jane Doe', email: 'jdoe@gmail.com', password: 'password')
      visit login_form_path
      
      fill_in :email, with: "jdoe@gmail.com"
      fill_in :password, with: "password"
      
      click_on "Log In"

      expect(page).to have_content(@user.email)
      expect(page).to have_content(user2.email)
      expect(page).to_not have_content(@user.name)
      expect(page).to_not have_content(user2.name)
    end

    it "goes to dashboard if you are logged in or register to access your dashboard" do
      visit dashboard_path
      
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Welcome, #{@user.name}")
    end
  end

  describe "Landing page as a visitor" do
    it "does not show list of existing users" do
      visit root_path
      
      expect(page).to have_button("Create User")
      expect(page).to have_link("Log-in form")
      expect(page).to_not have_link("John Smith")
      expect(page).to_not have_link("jdoe@gmail.com")
    end

    # As a visitor
    # When I visit the landing page
    # And then try to visit '/dashboard'
    # I remain on the landing page
    # And I see a message telling me that I must be logged in or registered to access my dashboard    
    it "remains on landing page when trying to visit dashboard" do
      visit root_path

      visit dashboard_path
      
      expect(current_path).to eq(root_path)
      expect(page).to have_content("You must be logged in or registered to access your dashboard")
    end
  end
end
  
    