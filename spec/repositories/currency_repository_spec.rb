require "rails_helper"

describe CurrencyRepository do
  let(:repository) { CurrencyRepository.new }

  it_behaves_like "TranslatableRepository"
end
