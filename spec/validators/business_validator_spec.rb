require "rails_helper"

describe BusinessValidator do
  subject { BusinessValidator.new(business_params) }

  let(:business_type) { create(:business_type) }
  let(:business) { build(:business) }
  let(:valid_params) do
    build_business_params(business, business_type_ids: [business_type.id])
  end
  let(:business_params) { valid_params }

  it { is_expected.to be_valid }

  describe "presence validation" do
    [:name, :country_id, :phone, :business_type_ids].each do |field|
      let(:business_params) do
        valid_params.merge(field => "")
      end

      it "requires #{field} to be present" do
        is_expected.to be_invalid
      end
    end
  end

  describe "length validation" do
    [:name, :country_id, :phone, :city, :address_line_1, :address_line_2,
     :no_of_employees].each do |field|
      let(:business_params) do
        too_long_field = "a" * (A9n.validations[:max_text_field_size] + 1)
        valid_params.merge(field => too_long_field)
      end

      it "requires #{field} to be shorter than
        #{A9n.validations[:max_text_field_size]}" do
        is_expected.to be_invalid
      end
    end

    let(:business_params) do
      too_long_field = "a" * (A9n.validations[:max_name_length] + 1)
      valid_params.merge(name: too_long_field, city: too_long_field)
    end

    it "requires name and city to be shorter than
      #{A9n.validations[:max_name_length]}" do
      is_expected.to be_invalid
    end

    let(:business_params) do
      too_long_field = "a" * (A9n.validations[:max_phone_length] + 1)
      valid_params.merge(phone: too_long_field)
    end

    it "requires phone to be shorter than
      #{A9n.validations[:max_phone_length]}" do
      is_expected.to be_invalid
    end

    let(:business_params) do
      too_long_field = "a" * (A9n.validations[:max_text_area_size] + 1)
      valid_params.merge(introduction: too_long_field)
    end

    it "requires introduction to be shorter than
      #{A9n.validations[:max_text_area_size]}" do
      is_expected.to be_invalid
    end
  end

  describe "#no_of_employees" do
    it_behaves_like "positive integer" do
      let(:business_params) { valid_params.merge(no_of_employees: field) }
    end
  end

  describe "year_registered" do
    context "number too big" do
      let(:business_params) do
        valid_params.merge(year_registered: 123_123_123_123)
      end

      it { is_expected.to be_invalid }
    end

    context "number is valid year but not reasonable one" do
      let(:business_params) do
        valid_params.merge(year_registered: 1000)
      end

      it { is_expected.to be_invalid }
    end
  end
end
