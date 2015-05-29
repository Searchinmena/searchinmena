require 'rails_helper'

describe UserFactory do
  fake(:user_repository)
  fake(:facebook_user_repository)

  subject { UserFactory.new(user_repository, facebook_user_repository) }

  describe "#hash" do
    it { expect(subject.hash[:user]).to eq(user_repository) }
    it { expect(subject.hash[:facebook]).to eq(facebook_user_repository) }
  end

  describe "#build" do
    context "params not set" do
      let(:attributes) { nil }

      it "initializes user" do
        expect(user_repository).to receive(:new).with({})
        subject.build(attributes)
      end
    end

    context "facebook auth" do
      let(:attributes) { { "provider" => "facebook", "uid" => "1234567" } }

      it "initializes facebook user" do
        expect(facebook_user_repository).to receive(:new).with(attributes)
        subject.build(attributes)
      end
    end

    context "any other provider" do
      let(:attributes) { { "provider" => "asdf" } }

      it "initializes user" do
        expect(user_repository).to receive(:new).with(attributes)
        subject.build(attributes)
      end
    end
  end
end
