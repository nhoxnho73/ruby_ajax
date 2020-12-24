require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "association message" do
    context "with test create data table message" do
      let(:user) { create(:user) }
      let(:room) { create(:room, user: user) }
      let(:message) { create(:message, user: user, room: room) }
      it "check valid" do
        expect(message).to be_valid
      end
    end
  end
end
