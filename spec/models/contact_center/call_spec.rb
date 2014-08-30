require 'rails_helper'

module ContactCenter
  RSpec.describe Call, type: :model, focus: true do
    describe "model basics" do
      context "call_status" do
        it "defaults to pending" do
          call = build(:call)
          expect(call.call_status).to eq 'pending'
        end

        it "can be set to a supported call status" do
          call = build(:call, call_status: 'ringing')
          expect(call.call_status).to eq 'ringing'
        end

        it "raises an error if the call status is not supported" do
          expect { build(:call, call_status: 'unknown') }.to raise_error ArgumentError
        end
      end
    end
  end
end
