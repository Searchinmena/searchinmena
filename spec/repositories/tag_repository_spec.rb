require "rails_helper"

describe TagRepository do
  let(:repository) { TagRepository.new }

  it_behaves_like "TranslatableRepository"

  describe "#find_with_query" do
    let(:locale) { 'en' }
    subject { repository.find_with_query(query, locale) }

    def tag_with_translation(value, locale)
      translation = create(:translation, value: value, locale: locale)
      create(:tag_with_translation, translation: translation)
    end

    let!(:tag) do
      create(:tag_with_translation,
             translation: create(:translation, locale: locale))
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
