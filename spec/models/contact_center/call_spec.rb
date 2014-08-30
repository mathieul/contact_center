require 'rails_helper'

module ContactCenter
  RSpec.describe Call, type: :model do
    describe "model basics" do
      context "validation" do
        it "is valid without a provider status" do
          expect(build(:call, provider_status: nil)).to be_valid
        end

        it "is not valid with provider status not supported" do
          call = build(:call, provider_status: 'unknown')
          expect(call).not_to be_valid
          expect(call.errors[:provider_status].size).to eq 1
        end
      end
    end
  end
end
