require "rails_helper"

describe BusinessPresenter do
  describe "#as_json" do
    let(:presenter) { BusinessPresenter.new(business, locale) }
    let(:business) { build(:business) }
    let(:locale) { "en" }
    let(:translatable_repository) { double }
    let(:translation) { "Krakow" }

    subject { presenter.as_json }

    before do
      allow(presenter).to receive(:translatable_repository)
        .and_return(translatable_repository)
      expect(translatable_repository).to receive(:translation_for)
        .with(business.country, locale)
        .and_return(translation)
    end

    it "includes prefilled attributes" do
      is_expected.to include(
        id: business.id,
        name: business.name,
        phone: business.phone,
        city: business.city,
        country_id: business.country_id,
        country: translation,
        year_registered: business.year_registered,
        no_of_employees: business.no_of_employees,
        introduction: business.introduction,
        address_line_1: business.address_line_1,
        address_line_2: business.address_line_2,
        business_type_ids: business.business_type_ids
      )
    end
  end
end
