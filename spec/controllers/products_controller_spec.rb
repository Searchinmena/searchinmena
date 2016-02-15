# require "rails_helper"
#
# describe ProductsController do
#   it_behaves_like "BusinessItemsController", :product do
#     let(:repository) { ProductRepository.new }
#     let(:photos_repository) { ProductPhotoRepository.new }
#     let(:creator_class) { BusinessItem::ProductCreator }
#     let(:business_item_params) do
#       common_business_params.merge(
#         "model_number" => "222",
#         "brand_name" => "brand",
#         "min_order_quantity_number" => "2",
#         "min_order_quantity_unit_id" => "1"
#       )
#     end
#     let(:business_item) { create(:product, business: user.business) }
#   end
# end
