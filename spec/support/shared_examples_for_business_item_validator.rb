shared_examples "BusinessItemValidator" do
  subject { described_class.new(business_item_params) }

  let(:business_item_params) { valid_params }

  it { is_expected.to be_valid }

  describe "presence validation" do
    [:name, :category_id].each do |field|
      let(:business_item_params) do
        valid_params.merge(field => '')
      end

      it "requires #{field} to be present" do
        is_expected.to be_invalid
      end
    end
  end

  describe "length validation" do
    [:name, :fob_price, :port, :supply_ability_capacity,
     :packaging_details].each do|field|
      let(:business_item_params) do
        too_long_field = "a" * (A9n.validations[:max_text_field_size] + 1)
        valid_params.merge(field => too_long_field)
      end

      it "requires #{field} to be shorter than
        #{A9n.validations[:max_text_field_size]}" do
        is_expected.to be_invalid
      end
    end

    [:description].each do|field|
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

  describe "#supply_ability_capacity" do
    it_behaves_like "positive integer" do
      let(:business_item_params) do
        valid_params.merge(supply_ability_capacity: field)
      end
    end
  end

  describe "#fob_price" do
    it_behaves_like "price" do
      let(:business_item_params) { valid_params.merge(fob_price: field) }
    end
  end
end
