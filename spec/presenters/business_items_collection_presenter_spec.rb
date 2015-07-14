require "rails_helper"

describe BusinessItemsCollectionPresenter do
  describe "#as_json" do
    let!(:products) do
      20.times.map { create(:product, business: user.business) }
    end
    let(:user) { create(:seller) }
    let(:page) { "1" }
    let(:repository) { ProductRepository.new }
    let(:locale) { 'en' }

    let(:presenter) { described_class.new(user, page, repository, locale) }

    subject { presenter.as_json }

    it { expect(subject[:count]).to eq(20) }
    it "returns first page by default" do
      expect(subject[:items].as_json.map { |i| i[:id] }).to eq(
        products[0...10].map(&:id))
    end

    context "second page" do
      let(:page) { "2" }

      it { expect(subject[:count]).to eq(20) }
      it "returns second page of business items" do
        expect(subject[:items].as_json.map { |i| i[:id] }).to eq(
          products[10...20].map(&:id))
      end
    end
  end
end
