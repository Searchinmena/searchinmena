require "rails_helper"

describe Registration::UserCreator do
  let(:creator) { Registration::UserCreator.new(user, user_params) }
  let(:user) { double(:user) }
  let(:user_params) { double(:user_params) }

  fake(:user_validator)

  before do
    expect(UserValidator).to receive(:new).with(user_params)
    .and_return(user_validator)
  end

  describe "#valid?" do
    subject { creator.valid? }

    it "delegates to user validator" do
      expect(user_validator).to receive(:valid?)
      subject
    end
  end

  describe "#perform" do
    fake(:user_repository)
    fake(:storing_handler)

    subject { creator.perform }

    before do
      expect(UserRepository).to receive(:new).and_return(user_repository)
      expect(StoringHandler).to receive(:new)
      .with(user, user_params, user_repository, user_validator)
      .and_return(storing_handler)
    end

    it "delegates to storing handler" do
      expect(storing_handler).to receive(:perform)
      subject
    end
  end

  describe "#copy_errors" do
    subject { creator.copy_errors }

    it "copies errors to business" do
      expect(user_validator).to receive(:copy_errors)
        .with(user)
      subject
    end
  end
end

