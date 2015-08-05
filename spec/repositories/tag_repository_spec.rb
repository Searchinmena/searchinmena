require "rails_helper"

describe TagRepository do
  let(:repository) { TagRepository.new }
  let(:locale) { "en" }

  it_behaves_like "TranslatableRepository"

  def tag_with_translation(value, locale)
    translation = create(:translation, value: value, locale: locale)
    create(:tag, translations: [translation])
  end

  describe "#for_business_with_translations" do
    let!(:not_matching_tag) { tag_with_translation("not_matching_tag", locale) }
    let!(:tags) { [tag_with_translation("matching_tag", locale)] }
    let(:business) { create(:business, tags: tags) }

    subject { repository.for_business_with_translations(business.id, locale) }

    it "should return translated tags for business" do
      is_expected.to eq(tags)
      is_expected.not_to include(not_matching_tag)
    end
  end

  describe "#find_with_query" do
    subject { repository.find_with_query(query, locale) }

    let!(:tag) do
      create(:tag, translations: [create(:translation, locale: locale)])
    end
    let!(:matching_tag1) { tag_with_translation("AniasomethingB", locale) }
    let!(:matching_tag2) { tag_with_translation("AniasomethingA", locale) }
    let!(:not_matching_tag) { tag_with_translation("somethingAnia", locale) }

    context "query is blank" do
      let(:query) { "" }
      it "returns all tags in alphabetic order" do
        is_expected.to eq([matching_tag2, matching_tag1, not_matching_tag, tag])
      end
    end

    shared_examples_for "returns tags that matches query from the beginning" do
      it "returns tags in alphabetic order" do
        is_expected.to eq([matching_tag2, matching_tag1])
      end
    end

    context "query is present" do
      let(:query) { "Ania" }

      it_behaves_like "returns tags that matches query from the beginning"
    end

    context "query should be case insensitive" do
      let(:query) { "ania" }

      it_behaves_like "returns tags that matches query from the beginning"
    end
  end
end
