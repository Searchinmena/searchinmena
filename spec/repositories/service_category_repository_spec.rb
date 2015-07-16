require "rails_helper"

describe ServiceCategoryRepository do
  let(:repository) { ServiceCategoryRepository.new }

  it_behaves_like "TranslatableRepository"
  it_behaves_like "CategoryRepository", :service_category
end
