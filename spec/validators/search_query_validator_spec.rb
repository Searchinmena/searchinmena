require "rails_helper"

describe SearchQueryValidator do
  let(:validator) { SearchQueryValidator.new(query) }
  let(:query) { "query" }

  describe "#valid?" do
    subject { validator }

    it { is_expected.to be_valid }

    context "query is blank" do
      let(:query) { "" }

      it { is_expected.not_to be_valid }
    end
  end

  describe "#errors" do
    subject { validator.errors }

    let(:query) { "" }

    before do
      validator.valid?
    end

    it { is_expected.not_to be_empty }
  end
end
