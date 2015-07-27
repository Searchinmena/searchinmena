require "rails_helper"

describe BusinessRepository do
  let(:repository) { BusinessRepository.new }

  it_behaves_like "any repository"

  let(:business) { create(:business) }

  describe "#add_tag" do
    let(:tag) { create(:tag) }

    subject { repository.add_tag(business, tag) }

    it "changes tags count properly" do
      expect { subject }.to change { business.tags.count }
        .from(0).to(1)
    end

    it "assigns tag to business" do
      subject
      expect(business.tags.first).to eq(tag)
    end
  end

  describe "#find_by_user_id" do
    subject { repository.find_by_user_id(user.id) }

    context "user with business" do
      let(:user) { create(:seller, business: business) }

      it { is_expected.to eq(business) }
    end

    context "user without business" do
      let(:user) { create(:user) }

      it { is_expected.to eq(nil) }
    end
  end
end
