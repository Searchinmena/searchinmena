require "rails_helper"

describe UserRepository do
  let(:repository) { UserRepository.new }

  let(:auth) do
    {
      "provider" => "facebook",
      "uid" => "1234567"
    }
  end

  describe "#find_by_omniauth" do
    subject { repository.find_by_omniauth(auth) }

    context "when user doesn't exist" do
      it { expect(subject).to be_nil }
    end

    context "when user exists" do
      let!(:user) { create(:user, provider: "facebook", uid: "1234567") }

      it { expect(subject).to eq(user) }
    end
  end

  describe "#setup" do
    let(:user) { build(:user) }

    before { subject.setup(user_params) }

    context "provider absent in params" do
      let(:user_params) { { "email" => user.email } }

      it { expect(user_params).to eq("email" => user.email) }
    end

    context "provider present in params" do
      let(:user_params) { { "email" => user.email, "provider" => "facebook" } }

      it { expect(user_params).to include("password", "password_confirmation") }
      it { expect(user_params["password"]).not_to be_empty }
      it { expect(user_params["password_confirmation"]).not_to be_empty }
    end
  end

  describe "#update_category" do
    let(:user) { build(:buyer) }
    let(:category) { "both" }

    before { subject.update_category(user, category) }

    it { expect(user.category).to eq(category) }
  end
end
