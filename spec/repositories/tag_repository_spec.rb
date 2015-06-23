require "rails_helper"

describe TagRepository do
  let(:repository) { TagRepository.new }

  it_behaves_like "any repository"

  describe "#find_with_query" do
    subject { repository.find_with_query(query) }

    let!(:tag) { create(:tag) }
    let!(:matching_tag1) { create(:tag, name: "AniasomethingB") }
    let!(:matching_tag2) { create(:tag, name: "AniasomethingA") }
    let!(:not_matching_tag) { create(:tag, name: "somethingAnia") }

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
