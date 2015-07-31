require "rails_helper"

describe TagsStoringHandler do
  let(:handler) do
    described_class.new(business, tags_params, locale)
  end
  let(:business) { double(:business) }
  let(:tags_params) { [attributes] }
  let(:locale) { "en" }

  let(:attributes) { { label: "Ania" } }
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
      expect(tag_repository).to receive(:find_or_create_by_translation)
        .with("Ania", "en").and_return(tag)
      expect(business_repository).to receive(:update_tags)
        .with(business, [tag]).and_return(true)

      is_expected.to be_successful
    end

    context "tag id is passed (tag is already saved)" do
      let(:attributes) { { label: "Ania", id: 7 } }

      it "finds tag by id" do
        expect(tag_repository).to receive(:find_by_id)
          .with(7).and_return(tag)
        expect(business_repository).to receive(:update_tags)
          .with(business, [tag]).and_return(true)

        is_expected.to be_successful
      end
    end
  end
end
