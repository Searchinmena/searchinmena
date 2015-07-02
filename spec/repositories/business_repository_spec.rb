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

  describe "#add_business_type" do
    let(:business) { create(:business) }
    let(:business_type) { create(:business_type) }

    subject { repository.add_business_type(business, business_type) }

    it "changes business_types count properly" do
      expect { subject }.to change { business.business_types.count }
        .from(0).to(1)
    end

    it "assigns business_type to business" do
      subject
      expect(business.business_types.first).to eq(business_type)
    end
  end
end
