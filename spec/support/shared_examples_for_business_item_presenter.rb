shared_examples "BusinessItemPresenter" do
  let(:presenter) { described_class.new(business_item, repository, locale) }

  let(:locale) { "en" }
  let(:expected_keys) do
    [
      :id,
      :business_id,
      :name,
      :description,
      :fob_price,
      :fob_price_currency,
      :fob_price_unit,
      :port,
      :supply_ability_capacity,
      :supply_ability_unit,
      :supply_ability_frequency,
      :packaging_details,
      :breadcrumbs,
      :attributes,
      :photos,
      :cover_photo,
      :payment_terms
    ]
  end

  def payment_term_with_translation(locale)
    payment_term = create(:payment_term)
    translation = create(:translation,
                         translatable: payment_term,
                         locale: locale)
    payment_term.translations << translation
    payment_term
  end

  describe "#as_json" do
    subject { presenter.as_json }

    let(:currency) do
      c = create(:currency)
      create(:translation, translatable: c, locale: locale, value: "USD")
      c
    end

    let(:unit) do
      u = create(:unit)
      create(:translation, translatable: u, locale: locale, value: "Box/Boxes")
      u
    end

    let(:frequency) do
      f = create(:frequency)
      create(:translation, translatable: f, locale: locale, value: "Quater")
      f
    end

    before do
      expect(BusinessItemCategoryPresenter).to receive(:new)
        .with(business_item.category, locale).and_return("category")
      expect(PhotoPresenter).to receive(:new).and_return("photo")
      expect(AttributePresenter).to receive(:new).and_return("attribute")
      expect(PaymentTermPresenter).to receive(:new).and_return("payment_term")

      business_item.fob_price = 0.33
      business_item.fob_price_currency = currency
      business_item.fob_price_unit = unit
      business_item.supply_ability_unit = unit
      business_item.supply_ability_frequency = frequency
    end

    it { expect(subject.keys).to eq(expected_keys + additional_keys) }
    it { expect(subject[:breadcrumbs]).to eq("category") }
    it { expect(subject[:attributes]).to eq(["attribute"]) }
    it { expect(subject[:photos]).to eq(["photo"]) }
    it { expect(subject[:payment_terms]).to eq(["payment_term"]) }
    it { expect(subject[:fob_price]).to eq(0.33) }
    it { expect(subject[:fob_price_currency]).to eq("USD") }
    it { expect(subject[:fob_price_unit]).to eq("Box/Boxes") }
    it { expect(subject[:supply_ability_unit]).to eq("Box/Boxes") }
    it { expect(subject[:supply_ability_frequency]).to eq("Quater") }
  end
end
