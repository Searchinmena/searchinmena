require "rails_helper"

describe BusinessRepository do
  let(:repository) { BusinessRepository.new }

  it_behaves_like "any repository"

  describe "#assign_tags" do
    let(:tags) { [build(:tag)] }
    let(:business) { create(:business, tags: []) }
    subject { repository.assign_tags(business, tags) }

    context "adding tags" do
      it "changes tags count properly" do
        expect { subject }.to change { business.tags.count }
          .from(0).to(1)
      end

      it "assigns tag to business" do
        subject
        expect(business.tags.all).to eq(tags)
      end
    end

    context "removing tags" do
      let(:tags) { [] }
      let(:business) { create(:business, tags: [build(:tag)]) }

      it "changes tags count properly" do
        expect { subject }.to change { business.tags.count }
          .from(1).to(0)
      end
    end
  end

  describe "#find_by_user_id" do
    let(:business) { create(:business) }

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
