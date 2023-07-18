# require 'rails_helper'

# RSpec.describe MovieFacade do
#   describe 'class methods' do
#     describe '#top_rated_movies' do
#       xit 'returns the top 20 movies' do
#         movies = MovieFacade.new({ type: 'top20rated' }).search

#         expect(movies).to be_an(Array)
#         expect(movies.count).to eq(20)

#         expect(movies.first).to be_a(Movie)
#         expect(movies.first.title).to be_a(String)
#         expect(movies.first.vote_average).to be_a(Float)
#       end
#     end

#     describe '#search_movies' do
#       xit 'returns the movies that matched the search name' do
#         movies = MovieFacade.new({ title: 'Pulp Fiction' }).search

#         expect(movies).to be_an(Array)
#         expect(movies.count).to eq(7)

#         expect(movies.first).to be_a(Movie)
#         expect(movies.first.title).to be_a(String)
#         expect(movies.first.title).to include('Pulp Fiction')
#         expect(movies.first.vote_average).to be_a(Float)
#       end

#       it 'returns an empty array if no movies matched the search' do
#         movies = MovieFacade.new({ title: 'bruhbruhbruh' }).search

#         expect(movies).to eq([])
#         expect(movies.count).to eq(0)
#       end
#     end

#     describe '#search_movies_by_id' do
#       it 'returns the movie that matches the id' do
#         movie = MovieFacade.new({ id: 680 }).search

#         expect(movie).to be_a(Movie)
#         expect(movie.title).to be_a(String)
#         expect(movie.title).to eq('Pulp Fiction')
#         expect(movie.vote_average).to be_a(Float)
#         expect(movie.runtime).to be_a(Integer)
#         expect(movie.summary).to be_a(String)
#       end
#     end
#   end
# end
