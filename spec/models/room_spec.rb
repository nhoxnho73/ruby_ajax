require 'rails_helper'

RSpec.describe Room, type: :model do
  describe "association room" do
    context "with test create data table room" do
      let(:user) { create(:user) }
      let(:room) { create(:room, user: user) }
      it "check valid" do
        expect(room).to be_valid
      end
    end
  end
end
