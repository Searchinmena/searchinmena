require "rails_helper"

describe Registration::Creator do
  describe "#perform" do
    let(:service) do
      Registration::Creator.new(registration_params)
    end

    subject { service.perform }

    let(:registration_params) do
      {
        user: user_params,
        business: business_params,
        tags: [{ name: "Ania" }]
      }
    end

    let(:business_type) { create(:business_type) }
    let(:user) { build(:user, category: User.categories[:seller]) }
    let(:business) { build(:business, user: nil, business_types: []) }
    let(:valid_user_params) { build_user_params(user) }
    let(:valid_business_params) do
      build_business_params(business, [business_type.id])
    end

    shared_examples_for "any invalid params" do
      it { is_expected.not_to be_successful }

      it "doesn't create user" do
        expect { subject }.not_to change { User.count }
      end

      it "doesn't create business" do
        expect { subject }.not_to change { Business.count }
      end
    end

    context "user has chosen 'seller' or 'both' category" do
      context "user params valid" do
        let(:user_params) { valid_user_params }

        context "business params valid" do
          let(:created_user) { User.where(email: user.email).first }
          let(:business_params) { valid_business_params }

          it { is_expected.to be_successful }

          it "assigns business to user" do
            subject
            expect(created_user.business).not_to be_nil
          end

          it "creates tags" do
            subject
            created_business = created_user.business
            expect(created_business.tags).not_to be_empty
          end

          it "creates business types" do
            subject
            expect(created_user.business.business_types).not_to be_empty
          end
        end

        context "business params invalid" do
          let(:business_params) { {} }

          it_behaves_like "any invalid params"

          it "copies errors to business" do
            expect(subject.business.errors).not_to be_empty
          end
        end
      end

      context "user params invalid" do
        let(:user_params) { valid_user_params.merge(email: '') }

        context "business params valid" do
          let(:business_params) { valid_business_params }

          it { is_expected.not_to be_successful }

          it "doesn't create user" do
            expect { subject }.not_to change { User.count }
          end

          it "doesn't create business" do
            expect { subject }.not_to change { Business.count }
          end

          it "copies errors to user" do
            expect(subject.user.errors).not_to be_empty
          end
        end

        context "business params invalid" do
          let(:business_params) { {} }

          it_behaves_like "any invalid params"

          it "copies errors to business" do
            expect(subject.business.errors).not_to be_empty
          end
        end
      end
    end

    context "user has chosen 'buyer' category" do
      let(:valid_user_params) do
        build_user_params(user, category: User.categories[:buyer])
      end
      let(:business_params) { {} }

      context "user params valid" do
        let(:user_params) { valid_user_params }

        it { is_expected.to be_successful }
      end

      context "user params invalid" do
        let(:user_params) { valid_user_params.merge(email: "") }

        it { is_expected.not_to be_successful }
      end
    end
  end
end

