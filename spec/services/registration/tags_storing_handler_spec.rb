require "rails_helper"

describe Registration::TagsStoringHandler do
  let(:handler) do
    described_class.new(business, tags_params)
  end
  let(:business) { double(:business) }
  let(:tags_params) { [attributes] }

  let(:attributes) { { name: "Ania" } }
  let(:tag) { double(:tag) }

  describe "#perform" do
    subject { handler.perform }

    fake(:tag_repository)
    fake(:business_repository)

    before do
      expect(TagRepository).to receive(:new)
        .and_return(tag_repository)
      expect(BusinessRepository).to receive(:new)
        .and_return(business_repository)
    end

    it "adds tag" do
      expect(tag_repository).to receive(:find_or_create)
        .with(attributes).and_return(tag)
      expect(business_repository).to receive(:add_tag)
        .with(business, tag).and_return(true)

      is_expected.to be_successful
    end
  end
end
