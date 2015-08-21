require "rails_helper"

describe SearchResultsPresenter do
  let(:presenter) do
    SearchResultsPresenter.new(
      result_presenter_factory,
      results,
      page,
      locale
    )
  end

  let!(:results) { 20.times.map { |i| double(:product, id: i, created_at: i) } }
  let(:page) { "1" }
  let(:locale) { "en" }

  class FakePresenterFactory
    def build(result, locale)
      result
    end
  end

  let(:result_presenter_factory) { FakePresenterFactory.new }

  describe "#as_json" do
    subject { presenter.as_json }

    it { expect(subject[:count]).to eq(20) }
    it "returns first page by default" do
      expect(subject[:items].map { |i| i.id }).to eq(
        results[10...20].map(&:id).reverse)
    end

    context "second page" do
      let(:page) { "2" }

      it { expect(subject[:count]).to eq(20) }
      it "returns second page of business items" do
        expect(subject[:items].map { |i| i.id }).to eq(
          results[0...10].map(&:id).reverse)
      end
    end
  end
end

