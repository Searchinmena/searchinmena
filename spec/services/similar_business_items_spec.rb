# require "rails_helper"

# describe SimilarBusinessItems do

#   let(:product_repository) { ProductRepository.new }

#   describe "#perform" do
#     subject { service.perform }

#     context "finds business item by id" do
#       let(:business_item) { build(:service) }
#       let(:service) { described_class.new(product_repository, business_item.id) }
#       before do
#         expect(product_repository).to receive(:find_by_id).with(business_item.id).and_return(business_item)
#       end
#       it { is_expected.to be_successful  }
#     end
#   end
# end
