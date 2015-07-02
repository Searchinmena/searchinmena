require "rails_helper"

describe SampleService do
  describe "#perform" do
    let(:service) { SampleService.new(another_sample_service, user_repository) }

    # useful bogus helper, creates something like rspec's double
    # but with all the methods which another_sample_service should have stubbed
    fake(:another_sample_service)

    # sometimes you can stub repository, sometimes test makes more sens, when
    # you use real one:
    # let(:user_repository) { UserRepository.new }
    fake(:user_repository)

    # useful method from factory_girl when we have User model and user factory
    # let(:user) { build(:user) }
    # let(:user_id) { user.id }
    #
    # or just rspec's double if you don't need model here
    let(:user) { double }
    let(:user_id) { 7 }

    subject { service.perform(user_id) }

    before do
      expect(another_sample_service).to receive(:perform)
        .and_return(Response.new(success: success))
    end

    context "another service returns success" do
      let(:success) { true }

      it { expect(subject.successful?).to be true }

      # more tests...
    end

    context "another service returns error" do
      let(:success) { false }

      it { expect(subject.successful?).to be false }

      # more tests...
    end
  end
end
