shared_examples "BusinessItemPresenter" do
  let(:presenter) do
    described_class.new(business_item, repository, photos_repository, locale)
  end

  let(:locale) { "en" }
  let(:expected_keys) do
    [
      :id,
      :business,
      :name,
      :category_id,
      :description,
      :fob_price,
      :fob_price_currency,
      :fob_price_currency_id,
      :fob_price_unit,
      :fob_price_unit_id,
      :port,
      :supply_ability_capacity,
      :supply_ability_unit,
      :supply_ability_unit_id,
      :supply_ability_frequency,
      :supply_ability_frequency_id,
      :packaging_details,
      :breadcrumbs,
      :attributes,
      :photos,
      :cover_photo,
      :payment_terms
    ]
  end

  describe "#as_json" do
    subject { presenter.as_json }

    let(:currency) do
      c = create(:currency, translations: [])
      create(:translation, translatable: c, locale: locale, value: "USD")
      c
    end

    let(:unit) do
      u = create(:unit, translations: [])
      create(:translation, translatable: u, locale: locale, value: "Box/Boxes")
      u
    end

    let(:frequency) do
      f = create(:frequency, translations: [])
      create(:translation, translatable: f, locale: locale, value: "Quater")
      f
    end

    let(:business) { create(:business, country: country) }
    let(:country) { create(:country, translations: []) }
    let!(:country_translation) do
      create(:translation, translatable: country,
                           locale: locale,
                           value: "Poland")
    end

    before do
      expect(BusinessItemCategoryPresenter).to receive(:new)
        .with(business_item.category, locale).and_return("category")
      expect(PhotoPresenter).to receive(:new).and_return("photo")
      expect(AttributePresenter).to receive(:new).and_return("attribute")
      expect(PaymentTermsPresenter).to receive(:new).and_return("payment_terms")

      business_item.fob_price = 0.33
      business_item.fob_price_currency = currency
      business_item.fob_price_unit = unit
      business_item.supply_ability_unit = unit
      business_item.supply_ability_frequency = frequency
    end

    it { expect(Set.new(subject.keys)).to eq(Set.new(expected_keys + additional_keys)) }
    it { expect(subject[:breadcrumbs]).to eq("category") }
    it { expect(subject[:attributes]).to eq(["attribute"]) }
    it { expect(subject[:photos]).to eq(["photo"]) }
    it { expect(subject[:payment_terms]).to eq("payment_terms") }
    it { expect(subject[:fob_price]).to eq(0.33) }
    it { expect(subject[:fob_price_currency]).to eq("USD") }
    it { expect(subject[:fob_price_unit]).to eq("Box/Boxes") }
    it { expect(subject[:supply_ability_unit]).to eq("Box/Boxes") }
    it { expect(subject[:supply_ability_frequency]).to eq("Quater") }

    context "returns business data" do
      subject { presenter.as_json[:business].as_json }

      it { expect(subject[:id]).to eq(business.id) }
      it { expect(subject[:name]).to eq(business.name) }
      it { expect(subject[:city]).to eq(business.city) }
      it { expect(subject[:country]).to eq(country_translation.value) }
    end
  end
end
