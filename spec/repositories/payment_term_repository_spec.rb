require "rails_helper"

describe PaymentTermRepository do
  let(:repository) { PaymentTermRepository.new }

  it_behaves_like "TranslatableRepository"
end
