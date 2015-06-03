require 'rails_helper'

describe Api::TagPresenter do
  describe "#as_json" do
    let(:presenter) { Api::TagPresenter.new(tag) }
    let(:tag) { build(:tag) }

    subject { presenter.as_json }

    it { is_expected.to eq(name: tag.name) }
  end
end
