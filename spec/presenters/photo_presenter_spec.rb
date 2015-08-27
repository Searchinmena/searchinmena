require "rails_helper"

describe PhotoPresenter do
  describe "#as_json" do
    let(:product_photo) { create(:product_photo) }
    let(:repository) { ProductPhotoRepository.new }
    let(:presenter) { described_class.new(product_photo, repository) }

    subject { presenter.as_json.keys }

    it { is_expected.to eq([:id, :thumb, :bigger_thumb, :url]) }
  end
end
