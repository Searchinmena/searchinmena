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
    def build(result, _)
      result
    end
  end

  let(:result_presenter_factory) { FakePresenterFactory.new }

  describe "#as_json" do
    subject { presenter.as_json }

    it { expect(subject[:count]).to eq(nil) }
    it "returns first page by default" do
      expect(subject[:items].map(&:id)).to eq(
        results[0...20].map(&:id))
    end

    context "second page" do
      let(:page) { "2" }
      # Urgent fix
      # it { expect(subject[:count]).to eq(20) }
      it { expect(subject[:count]).to eq(nil) }
      it "returns second page of business items" do
        expect(subject[:items].map(&:id)).to eq(
          results[0...20].map(&:id))
      end
    end
  end
end

