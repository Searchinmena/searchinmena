require "rails_helper"

describe BusinessPresenter do
  describe "#as_json" do
    let(:presenter) { BusinessPresenter.new(business) }
    let(:business) { build(:business) }

    subject { presenter.as_json }

    it "includes prefilled attributes" do
      is_expected.to include(
        id: business.id,
        name: business.name,
        phone: business.phone,
        city: business.city,
        country_id: business.country_id,
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
