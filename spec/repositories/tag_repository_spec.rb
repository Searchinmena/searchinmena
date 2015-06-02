require "rails_helper"

describe TagRepository do
  let(:repository) { TagRepository.new }

  describe "#find_or_create" do
    let(:tag) { build(:tag) }
    let(:name) { tag.name }

    subject { repository.find_or_create(name: name) }

    context "record already present" do
      before do
        tag.save
      end

      it { is_expected.to eq(tag) }
      it { expect { subject }.not_to change { Tag.count } }
    end

    context "record not yet present" do
      it { is_expected.to eq(Tag.where(name: name).first) }
      it { expect { subject }.to change { Tag.count }.from(0).to(1) }
    end
  end

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

    context "query is present" do
      let(:query) { "Ania" }

      it "returns tags that matches query from the beginning
      in alphabetic order" do
        is_expected.to eq([matching_tag2, matching_tag1])
      end
    end
  end
end
