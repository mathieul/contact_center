require 'rails_helper'

module ContactCenter
  RSpec.describe Concerns::CallStateMachine, type: :model do
    describe '#state' do
      let(:call) { build :call }

      it "defaults to 'not_initiated'" do
        expect(call).to be_not_initiated
      end
    end

    describe "#connect!" do
      let(:call) { create(:call).tap &:connect! }

      it "transitions to 'connecting'" do
        expect(call).to be_connecting
      end
    end

    describe "#reject!" do
      let(:call) { create(:call).tap &:reject! }

      it "transitions to 'terminated'" do
        expect(call).to be_terminated
      end
    end

    describe "#busy!" do
      let(:call) { create(:connecting_call).tap &:busy! }

      it "transitions to 'terminated'" do
        expect(call).to be_terminated
      end
    end

    describe "#call_fail!" do
      let(:call) { create(:connecting_call).tap &:call_fail! }

      it "transitions to 'terminated'" do
        expect(call).to be_terminated
      end
    end

    describe "#call_fail!" do
      let(:call) { create(:connecting_call).tap &:answer! }

      it "transitions to 'in_progress'" do
        expect(call).to be_in_progress
      end

      it "sets the connected time" do
        expect(call.connected_at).to be_within(1.second).of(Time.zone.now)
      end
    end

    describe "#conference!" do
      context "given a call connecting" do
        let(:call) { create(:connecting_call).tap &:conference! }

        it "transitions to 'in_progress'" do
          expect(call).to be_in_conference
        end
      end

      context "given a call in progress" do
        let(:call) { create(:in_progress_call).tap &:conference! }

        it "transitions to 'in_progress'" do
          expect(call).to be_in_conference
        end
      end

      context "given a call in progress hold" do
        let(:call) { create(:in_progress_hold_call).tap &:conference! }

        it "transitions to 'in_progress'" do
          expect(call).to be_in_conference
        end
      end
    end

    describe "#dial_agent!" do
      context "given a call in conference" do
        let(:call) { create(:in_conference_call).tap &:dial_agent! }

        it "transitions to 'in_progress'" do
          expect(call).to be_in_progress
        end
      end

      context "given a call in progress" do
        let(:call) { create(:in_progress_call).tap &:dial_agent! }

        it "transitions to 'in_progress'" do
          expect(call).to be_in_progress
        end
      end

      context "given a call in progress hold" do
        let(:call) { create(:in_progress_hold_call).tap &:dial_agent! }

        it "transitions to 'in_progress'" do
          expect(call).to be_in_progress
        end
      end
    end

    describe "#complete_hold!" do
      context "given a call in progress" do
        let(:call) { create(:in_progress_call).tap &:complete_hold! }

        it "transitions to 'in_progress_hold'" do
          expect(call).to be_in_progress_hold
        end
      end
    end

    describe "#terminate!" do
      context "by default" do
        let(:call) { create(:connecting_call).tap &:terminate! }

        it "transitions to 'terminated'" do
          expect(call).to be_terminated
        end

        it "sets the disconnected time" do
          expect(call.disconnected_at).to be_within(1.second).of(Time.zone.now)
        end
      end

      context "given a call already terminated" do
        let(:call)    { create(:terminated_call, disconnected_at: 10.minutes.ago) }
        before(:each) { call.terminate! }

        it "stays 'terminated'" do
          expect(call).to be_terminated
        end

        it "doesn't update the disconnected time" do
          expect(call.disconnected_at).to be_within(1.second).of(10.minutes.ago)
        end
      end
    end
  end
end
