require "rails_helper"

describe ProductValidator do
  it_behaves_like "BusinessItemValidator" do
    let(:valid_params) { build_params(build(:product)) }
  end

  subject { described_class.new(business_item_params) }

  let(:business_item_params) { valid_params }
  let(:valid_params) { build_params(build(:service)) }

  it_behaves_like "BusinessItemValidator" do
    let(:valid_params) { build_params(build(:service)) }

    describe "additional length validation" do
      [:model_number, :brand_name, :min_order_quantity_number].each do|field|
        let(:business_item_params) do
          too_long_field = "a" * (A9n.validations[:max_text_field_size] + 1)
          valid_params.merge(field => too_long_field)
        end

        it "requires #{field} to be shorter than
          #{A9n.validations[:max_text_field_size]}" do
          is_expected.to be_invalid
        end
      end
    end
  end

  describe "#min_order_quantity_number" do
    it_behaves_like "positive integer" do
      let(:business_item_params) do
        valid_params.merge(min_order_quantity_number: field)
      end
    end
  end
end
