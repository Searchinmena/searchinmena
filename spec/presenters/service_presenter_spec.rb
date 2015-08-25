require "rails_helper"

describe ServicePresenter do
  it_behaves_like "BusinessItemPresenter" do
    let(:business_item) do
      item = create(:service, business: business)

      item.service_attributes << create(:service_attribute)
      item.payment_terms << create(:payment_term)

      item
    end

    let(:repository) { ServiceRepository.new }
    let(:photos_repository) { ServicePhotoRepository.new }

    let(:additional_keys) do
      [
        :place_of_origin,
        :scope_of_work,
        :average_completion_time,
        :average_completion_time_unit_id,
        :average_completion_time_unit
      ]
    end
  end
end
