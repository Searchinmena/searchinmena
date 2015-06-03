require "rails_helper"

describe UserRepository do
  let(:auth) do
    {
      "provider" => "facebook",
      "uid" => "1234567"
    }
  end

  describe "#find_by_omniauth" do
    subject { UserRepository.new.find_by_omniauth(auth) }

    context "when user doesn't exist" do
      it { expect(subject).to be_nil }
    end

    context "when user exists" do
      let!(:user) { create(:user, provider: "facebook", uid: "1234567") }

      it { expect(subject).to eq(user) }
    end
  end
end
