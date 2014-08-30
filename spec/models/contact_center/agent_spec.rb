require 'rails_helper'

module ContactCenter
  RSpec.describe Agent, type: :model, focus: true do
    describe "model basics" do
      context "validation" do
        it "requires a username" do
          agent = build(:agent, username: nil)
          expect(agent).not_to be_valid
          expect(agent.errors[:username].size).to eq(1)
        end

        it "requires a name" do
          agent = build(:agent, name: nil)
          expect(agent).not_to be_valid
          expect(agent.errors[:name].size).to eq(1)
        end

        it "requires a phone number if phone type is 'phone'" do
          agent = build(:agent, phone_type: 'phone', phone_number: nil)
          expect(agent).not_to be_valid
          agent.phone_number = '6502624400'
          expect(agent).to be_valid
        end

        it "requires a SIP URI if phone type is 'sip'" do
          agent = build(:agent, phone_type: 'sip', sip_uri: nil)
          expect(agent).not_to be_valid
          agent.sip_uri = 'agentsmith@thematrix'
          expect(agent).to be_valid
        end
      end

      context "new agent" do
        let(:agent) { build(:agent) }

        it "defaults its status to 'offline'" do
          expect(agent.status).to eq 'offline'
        end

        it "defaults its phone_type to 'twilio_client'" do
          expect(agent.phone_type).to eq Agent::PhoneType::TWILIO_CLIENT
        end
      end
    end

    describe "#transferrable?" do
      context "given an available agent" do
        let(:agent) { create :available_agent }

        it "returns true" do
          expect(agent).to be_transferrable
        end
      end

      context "given an unavailable agent" do
        let(:agent) { create :not_available_agent }

        it "returns true" do
          expect(agent).not_to be_transferrable
        end
      end
    end
  end
end
