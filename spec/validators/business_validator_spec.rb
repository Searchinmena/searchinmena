require 'rails_helper'

describe BusinessValidator do
  subject { BusinessValidator.new(business_params) }

  let(:valid_params) { build_params(build(:business)) }

  describe "presence validation" do
    [:name, :country, :phone, :business_type].each do |field|
      let(:business_params) do
        valid_params.merge(field => '')
      end

      it "requires #{field} to be present" do
        is_expected.to be_invalid
      end
    end
  end

  describe "length validation" do
    [:name, :country, :phone].each do |field|
      let(:business_params) do
        too_long_field = "a" * (A9n.validations[:max_text_field_size] + 1)
        valid_params.merge(field => too_long_field)
      end

      it "requires #{field} to be present" do
        is_expected.to be_invalid
      end
    end
  end
end
