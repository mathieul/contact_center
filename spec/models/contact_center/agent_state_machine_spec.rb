require 'rails_helper'

module ContactCenter
  RSpec.describe Concerns::AgentStateMachine, type: :model do
    describe "#status" do
      let(:agent) { create :agent }

      it "defaults to 'offline'" do
        expect(agent.status).to eq Agent::OFFLINE
      end
    end

    describe "#available!" do
      context "given an offline agent" do
        let(:agent) { create :offline_agent }

        it "transitions into available status" do
          agent.available!
          expect(agent.status).to eq Agent::AVAILABLE
        end
      end
    end

    describe "#offline!" do
      context "given an available agent" do
        let(:agent) { create :available_agent }

        it "transitions into offline status" do
          agent.offline!
          expect(agent.status).to eq Agent::OFFLINE
        end
      end
    end

    describe "#on_a_call!" do
      context "given an available agent" do
        let(:agent) { create :available_agent }

        it "transitions into on a call status" do
          agent.on_a_call!
          expect(agent.status).to eq Agent::ON_A_CALL
        end
      end
    end

    describe "#not_available!" do
      context "given an agent on a call" do
        let(:agent) { create :on_a_call_agent }

        it "does not transition to not available" do
          expect { agent.not_available! }.to raise_error(StateMachine::InvalidTransition)
        end
      end

      context "given an available agent" do
        let(:agent) { create :available_agent }

        it "transitions to not available" do
          agent.not_available!
          expect(agent.status).to eq Agent::NOT_AVAILABLE
        end
      end
    end

    describe "after state transition" do
      before do
        @subscriber = ActiveSupport::Notifications.subscribe("contact_center.agent_status_change") do |*args|
          @event = ActiveSupport::Notifications::Event.new(*args)
        end
      end

      after do
        ActiveSupport::Notifications.unsubscribe(@subscriber)
      end

      context "when the status changes" do
        let(:agent) { create :offline_agent }
        before { agent.available! }

        it "publishes the status change" do
          expect(@event).not_to be_nil
          expect(@event.payload[:agent_id]).to eq agent.id
          expect(@event.payload[:username]).to eq agent.username
          expect(@event.payload[:status]).to eq agent.status
          expect(@event.payload).to include :timestamp
        end
      end

      context "when status doesn't change" do
        let(:agent) { create :available_agent }
        before { agent.available! }

        it "does not publish the status change" do
          expect(@event).to be_nil
        end
      end
    end
  end
end
