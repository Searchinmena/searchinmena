require "rails_helper"

describe BusinessRepository do
  let(:repository) { BusinessRepository.new }

  describe "#add_tag" do
    let(:business) { create(:business) }
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
end
