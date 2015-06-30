require "rails_helper"

describe BusinessTypeRepository do
  let(:repository) { BusinessTypeRepository.new }

  it_behaves_like "TranslatableRepository"
end
