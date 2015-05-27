require 'rails_helper'

describe BusinessPresenter do
  describe "#options_for_business_types_select" do
    let(:presenter) { BusinessPresenter.new }

    subject { presenter.options_for_business_types_select }

    it { expect(subject.first).to eq(["Manufacturer", 0]) }
  end
end
