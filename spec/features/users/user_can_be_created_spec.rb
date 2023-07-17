# require 'rails_helper'

# # As a visitor 
# # When I visit `/register`
# # I see a form to fill in my name, email, password, and password confirmation.
# # When I fill in that form with my name, email, and matching passwords,
# # I'm taken to my dashboard page `/users/:id`


# RSpec.describe "User registration form" do
#   it "creates a new user" do
#     visit register_path
    
#     name = "funbucket13"
#     email = "funbucket13@gmail.com"
#     password = "test"
    
#     fill_in :name, with: name
#     fill_in :email, with: email
#     fill_in :password, with: password
    
#     click_on "Register as a User"
    
#     expect(current_path).to eq(users_path)
#   end
# end