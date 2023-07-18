# require 'rails_helper'

# describe MovieService do
#   describe 'instance methods' do
#     describe '#top_rated_movies' do
#       it 'returns the top 20 movies' do
#         movies = MovieService.new.top_rated_movies
#         results = movies[:results]

#         expect(results).to be_an(Array)
#         expect(results.count).to eq(20)

#         expect(results.first).to have_key(:title)
#         expect(results.first[:title]).to be_a(String)

#         expect(results.first).to have_key(:vote_average)
#         expect(results.first[:vote_average]).to be_a(Float)
#       end
#     end

#     describe '#search_movies' do
#       it 'returns the movies that matched the search name' do
#         movies = MovieService.new.search_movies('Pulp Fiction')
#         results = movies[:results]

#         expect(results).to be_an(Array)
#         expect(results.count).to eq(7)

#         expect(results.first).to have_key(:title)
#         expect(results.first[:title]).to be_a(String)
#         expect(results.first[:title]).to include('Pulp Fiction')

#         expect(results.first).to have_key(:vote_average)
#         expect(results.first[:vote_average]).to be_a(Float)
#       end

#       it 'returns an empty array if no movies matched the search' do
#         movies = MovieService.new.search_movies('bruhbruhbruh')
#         results = movies[:results]

#         expect(results).to eq([])
#         expect(results.count).to eq(0)
#       end
#     end

#     describe '#search_movies_by_id' do
#       it 'returns the movie that matched the search ID' do
#         movie = MovieService.new.search_movies_by_id(221)

#         expect(movie).to be_a(Hash)
#         expect(movie).to have_key(:title)
#         expect(movie[:title]).to be_a(String)
#         expect(movie[:title]).to eq('Rebel Without a Cause')

#         expect(movie).to have_key(:vote_average)
#         expect(movie[:vote_average]).to be_a(Float)
#         expect(movie[:vote_average]).to eq(7.561)
#       end
#     end

#     describe '#find_cast' do
#       it 'returns the cast of the movie that matched the search ID' do
#         movie = MovieService.new.find_cast(221)
#         cast = movie[:cast]

#         expect(cast).to be_an(Array)
#         expect(cast.count).to eq(42)
#         expect(cast.first).to have_key(:name)
#         expect(cast.first[:name]).to be_a(String)
#       end
#     end

#     describe '#find_reviews' do
#       it 'returns the reviews of the movie that matched the search ID' do
#         movie = MovieService.new.find_reviews(680)
#         reviews = movie[:results]

#         expect(reviews).to be_an(Array)
#         expect(reviews.count).to eq(6)
#         expect(reviews.first).to have_key(:author)
#         expect(reviews.first).to have_key(:content)
#       end
#     end
#   end
# end
