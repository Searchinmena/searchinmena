require "rails_helper"

describe TagPresenter do
  describe "#as_json" do
    let(:presenter) { TagPresenter.new(tag) }
    let(:tag) { build(:tag) }

    subject { presenter.as_json }

    it { is_expected.to eq(name: tag.name) }
  end
end
