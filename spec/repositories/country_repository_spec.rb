require "rails_helper"

describe CountryRepository do
  let(:repository) { CountryRepository.new }

  it_behaves_like "TranslatableRepository"
end
