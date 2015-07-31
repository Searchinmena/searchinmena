require "rails_helper"

describe PagesController do
  describe "#home" do
    before do
      get :home
    end

    it { expect(response).to be_successful }
  end
end
