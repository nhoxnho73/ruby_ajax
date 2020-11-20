require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'association genre and movie' do
    context "with test create table movie" do
      let(:user) { create(:user) }
      let(:genre) { create(:genre) }
      let(:movie) { create(:movie, user: user, genre: genre) }
      it "is valid with valid attributes" do
        expect(movie).to be_valid
      end
    end
    
  end


end  