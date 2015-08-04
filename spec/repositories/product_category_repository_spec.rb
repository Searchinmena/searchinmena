require "rails_helper"

describe ProductCategoryRepository do
  let(:repository) { ProductCategoryRepository.new }

  it_behaves_like "TranslatableRepository" do
    def create_item
      create(:product_category, category_translations: [])
    end

    def create_translation(item, locale)
      create(:category_translation, category: item, locale: locale)
    end
  end
  it_behaves_like "CategoryRepository", :product_category
end
