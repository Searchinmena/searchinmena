require 'rails_helper'

describe UserValidator do
  subject { UserValidator.new(user_params) }

  let(:valid_params) { build_user_params(build(:user)) }
  let(:user_params) { valid_params }

  it { is_expected.to be_valid }

  describe "presence validation" do
    [:fist_name, :last_name, :email, :password, :password_confirmation,
     :category].each do |field|
      let(:user_params) do
        valid_params.merge(field => '')
      end

      it "requires #{field} to be present" do
        is_expected.to be_invalid
      end
    end
  end

  describe "length validation" do
    [:first_name, :last_name, :email, :password,
     :password_confirmation].each do|field|
      let(:user_params) do
        too_long_field = "a" * (A9n.validations[:max_text_field_size] + 1)
        valid_params.merge(field => too_long_field)
      end

      it "requires #{field} to be shorter than
        #{A9n.validations[:max_text_field_size]}" do
        is_expected.to be_invalid
      end
    end
  end

  describe "email format" do
    let(:user_params) { valid_params.merge(email: 'not an email') }

    it { is_expected.not_to be_valid }
  end

  describe "email uniqueness" do
    let!(:existing_user) { create(:user) }
    let(:user_params) { valid_params.merge(email: existing_user.email) }

    it { is_expected.not_to be_valid }
  end

  describe "password confirmation" do
    let(:user_params) do
      valid_params.merge(
        password: 'testtest',
        password_confirmation: 'testtest2'
      )
    end

    it { is_expected.not_to be_valid }
  end

  describe "password length" do
    let(:user_params) do
      valid_params.merge(
        password: 'test',
        password_confirmation: 'test'
      )
    end

    it { is_expected.not_to be_valid }
  end
end
