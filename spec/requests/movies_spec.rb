require 'rails_helper'

RSpec.describe 'Movie controller', type: :request, autodoc: true do
  describe "GET index" do
    context "when method GET" do
      let!(:user) { create(:user) }
      let!(:genre) { create(:genre) }
      let!(:movie) { create(:movie, user: user, genre: genre) }
      it "when get data movie" do
        binding.pry
        # sign_in user
        get "/movies"
        
        expect(response).to render_template(:index)
      end
    end
    
  end
end
