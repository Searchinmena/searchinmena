require 'rails_helper'

describe ServiceValidator do
  subject { described_class.new(business_item_params) }

  let(:business_item_params) { valid_params }
  let(:valid_params) { build_params(build(:service)).merge(photos_count: 1) }

  it_behaves_like "BusinessItemValidator" do
    let(:valid_params) { build_params(build(:service)).merge(photos_count: 1) }

    describe "additional length validation" do
      [:place_of_origin, :average_completion_time].each do|field|
        let(:business_item_params) do
          too_long_field = "a" * (A9n.validations[:max_text_field_size] + 1)
          valid_params.merge(field => too_long_field)
        end

        it "requires #{field} to be shorter than
          #{A9n.validations[:max_text_field_size]}" do
          is_expected.to be_invalid
        end
      end

      [:scope_of_work].each do|field|
        let(:business_item_params) do
          too_long_field = "a" * (A9n.validations[:max_text_area_size] + 1)
          valid_params.merge(field => too_long_field)
        end

        it "requires #{field} to be shorter than
          #{A9n.validations[:max_text_area_size]}" do
          is_expected.to be_invalid
        end
      end
    end
  end

  describe "#average_completion_time" do
    it_behaves_like "positive integer" do
      let(:business_item_params) do
        valid_params.merge(average_completion_time: field)
      end
    end
  end
end
