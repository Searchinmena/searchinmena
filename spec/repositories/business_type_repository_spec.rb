require "rails_helper"

describe BusinessTypeRepository do
  let(:repository) { BusinessTypeRepository.new }
  let(:locale) { 'en' }

  it_behaves_like "TranslatableRepository"

  def business_type_with_translation(value, locale)
    translation = create(:translation, value: value, locale: locale)
    create(:business_type, translations: [translation])
  end

  describe "#for_business_with_translations" do
    let!(:not_matching_business_type) do
      business_type_with_translation('Not Matching', 'en')
    end
    let!(:business_types) { [business_type_with_translation('Matching', 'en')] }
    let(:business) { create(:business, business_types: business_types) }

    subject { repository.for_business_with_translations(business.id, locale) }

    it "should return translated type for business" do
      is_expected.to eq(business_types)
      is_expected.not_to include(not_matching_business_type)
    end
  end
end
