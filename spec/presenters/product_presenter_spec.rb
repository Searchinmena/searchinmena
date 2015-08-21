require "rails_helper"

describe ProductPresenter do
  it_behaves_like "BusinessItemPresenter" do
    let(:business_item) do
      item = create(:product, business: business)

      item.product_attributes << create(:product_attribute)
      item.payment_terms << create(:payment_term)

      item
    end

    let(:repository) { ProductRepository.new }
    let(:photos_repository) { ProductPhotoRepository.new }

    let(:additional_keys) do
      [
        :model_number,
        :brand_name,
        :min_order_quantity_number,
        :min_order_quantity_unit
      ]
    end
  end
end
