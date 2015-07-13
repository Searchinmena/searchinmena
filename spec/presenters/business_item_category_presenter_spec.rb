require "rails_helper"

describe BusinessItemCategoryPresenter do
  describe "#as_json" do
    let(:category) { double(id: id) }
    let(:locale) { 'en' }
    let(:category_repository) { double }
    let(:presenter) do
      BusinessItemCategoryPresenter.new(category, locale)
    end

    let(:id) { 1 }
    let(:translation) { 'ania' }

    subject { presenter.as_json.first }

    before do
      allow(presenter).to receive(:category_repository)
        .and_return(category_repository)
      expect(category_repository).to receive(:hierarchy_for)
        .and_return([category])
      expect(category_repository).to receive(:translation_for)
        .with(category, locale)
        .and_return(translation)
    end

    it { is_expected.to eq(id: id, name: translation) }
  end
end

