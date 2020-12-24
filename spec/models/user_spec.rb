require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'association genre and movie' do
    context "with test create table user" do
      let(:user) { create(:user) }
      it "is valid with valid attributes" do
        expect(user).to be_valid
      end
    end
  end
end  
