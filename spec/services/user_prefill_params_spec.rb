require "rails_helper"

describe UserPrefillParams do
  let(:attributes) { {} }

  subject { UserPrefillParams.new(attributes).attributes }

  it { expect(subject).to eq({}) }
end
