require "rails_helper"

describe ProductCategoryRepository do
  let(:repository) { ProductCategoryRepository.new }

  it_behaves_like "TranslatableRepository"
  it_behaves_like "CategoryRepository", :product_category
end
