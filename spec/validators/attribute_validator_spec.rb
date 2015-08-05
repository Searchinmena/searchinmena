require "rails_helper"

describe AttributeValidator do
  subject { described_class.new(attribute_params) }

  let(:attribute_params) { valid_params }
  let(:valid_params) { build_params(build(:product_attribute)) }

  describe "length validation" do
    [:name, :value].each do|field|
      let(:attribute_params) do
        too_long_field = "a" * (A9n.validations[:max_text_field_size] + 1)
        valid_params.merge(field => too_long_field)
      end

      it "requires #{field} to be shorter than
        #{A9n.validations[:max_text_field_size]}" do
        is_expected.to be_invalid
      end
    end
  end

  describe "#value" do
    context "name is blank" do
      let(:attribute_params) { valid_params.merge(name: nil, value: nil) }

      it { is_expected.to be_valid }
    end

    context "name is present but value not" do
      let(:attribute_params) do
        valid_params.merge(name: "attribute", value: nil)
      end

      it { is_expected.to be_invalid }
    end

    context "value is present but name not" do
      let(:attribute_params) do
        valid_params.merge(value: "value", name: nil)
      end

      it { is_expected.to be_invalid }
    end
  end
end

