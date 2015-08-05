require "rails_helper"

describe ServiceCategoryRepository do
  let(:repository) { ServiceCategoryRepository.new }

  it_behaves_like "TranslatableRepository" do
    def create_item
      create(:service_category, category_translations: [])
    end

    def create_translation(item, locale)
      create(:category_translation, category: item, locale: locale)
    end
  end
  it_behaves_like "CategoryRepository", :service_category
end
