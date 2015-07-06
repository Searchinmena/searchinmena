require "rails_helper"

describe UserParamsFactory do
  fake(:user_prefill_params)
  fake(:facebook_user_prefill_params)

  describe "#hash" do
    it { expect(subject.hash[:user]).to eq(UserPrefillParams) }
    it { expect(subject.hash[:facebook]).to eq(FacebookUserPrefillParams) }
  end

  describe "#build" do
    after { subject.build(attributes) }

    context "params not set" do
      let(:attributes) { nil }

      it "returns user params with empty hash" do
        expect(UserPrefillParams).to receive(:new).with({})
          .and_return(user_prefill_params)
      end
    end

    context "facebook auth" do
      let(:attributes) { { "provider" => "facebook", "uid" => "1234567" } }

      it "returns facebook user params" do
        expect(FacebookUserPrefillParams).to receive(:new).with(attributes)
          .and_return(facebook_user_prefill_params)
      end
    end
  end
end
