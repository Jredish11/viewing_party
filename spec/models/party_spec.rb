require 'rails_helper'

RSpec.describe Party, type: :model do
  describe 'relationships' do
    it { should have_many :party_users }
    it { should have_many(:users).through(:party_users) }
  end

  describe 'validations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:duration) }
    it { should validate_presence_of(:movie_id) }
    it { should validate_presence_of(:host_id) }
  end

  describe 'instance methods' do
    describe '#movie_title' do
      it 'can find title of a movie by its id' do
        user = User.create!(name: 'John Smith', email: 'jsmith@aol.com')
        party = Party.create!(date: '2021-07-04', start_time: '17:00:00 UTC' , duration: 120, movie_id: 238, host_id: user.id)
        expect(party.movie_title(238)).to eq("The Godfather")
      end
    end

    describe '#host_name' do
      it 'finds the name of the host of a viewing party' do
        user1 = User.create!(name: 'John Smith', email: 'jsmith@aol.com')
        party1 = Party.create!(date: '2023-01-01', start_time: '08:00', duration: 275, movie_id: 238, host_id: user1.id)
        party_user1 = PartyUser.create!(user_id: user1.id, party_id: party1.id)
        
        expect(party1.host_name).to eq('John Smith')
      end
    end
  end
end
