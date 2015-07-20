require "rails_helper"

describe ServicePresenter do
  it_behaves_like "BusinessItemPresenter" do
    let(:business_item) do
      item = create(:service)

      item.service_attributes << create(:service_attribute)
      item.payment_terms << payment_term_with_translation(locale)

      item
    end

    let(:additional_keys) do
      [
        :place_of_origin,
        :scope_of_work,
        :average_completion_time,
        :average_completion_time_unit
      ]
    end
  end
end
