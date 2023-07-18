# require 'rails_helper'

# RSpec.describe "User's Movie Show page" do
#   before(:each) do
#     @user1 = User.create!(name: 'John Smith', email: 'jsmith@aol.com')
#     @movie1 = MovieFacade.new({ type: "top20rated" }).search.first
#     @movie1_by_id = MovieFacade.new({ id: @movie1.id.to_s }).search

#     visit user_movie_path(@user1, @movie1.id)
#   end

#   it "has a button to return to the Discover Page" do
#     expect(page).to have_button('Discover Page')
#     click_button('Discover Page')
#     expect(current_path).to eq(user_discover_path(@user1))
#   end

#   it "has a button to create a viewing party" do
#     expect(page).to have_button("Create Viewing Party for #{@movie1.title}")
#     click_button("Create Viewing Party for #{@movie1.title}")
#     expect(current_path).to eq("/users/#{@user1.id}/movies/#{@movie1.id}/viewing_party/new")
#   end

#   it "displays the movie's title" do
#     expect(page).to have_content(@movie1.title)
#   end

#   it "displays the movie's vote average" do
#     within('#movie-details') do
#       expect(page).to have_content(@movie1.vote_average)
#     end
#   end

#   it "displays the movie's runtime in hours & mins" do
#     within('#movie-details') do
#       expect(page).to have_content(@movie1.runtime.to_s)
#     end
#   end

#   it "displays the movie's genre(s)" do
#     within('#movie-details') do
#       expect(page).to have_content(@movie1_by_id.genres.join(", "))
#     end
#   end

#   it "displays the movie's summary" do
#     within('#movie-info') do
#       expect(page).to have_content(@movie1.summary)
#     end
#   end

#   it "lists the movie's first 10 cast members" do
#     within('#movie-info') do
#       expect(page).to have_content(@movie1_by_id.cast.join(", "))
#     end
#   end

#   it "diplays the total number of reviews for the movie" do
#     within('#movie-info') do
#       expect(page).to have_content("#{@movie1.num_reviews} Reviews")
#     end
#   end

#   it "displays each review's author and information" do
#     within('#movie-info') do
#       within('#reviews') do
#         expect(page).to have_content(@movie1_by_id.reviews.first[:author])
#         expect(page).to have_content(@movie1_by_id.reviews.last[:content])
#       end
#     end
#   end
# end
