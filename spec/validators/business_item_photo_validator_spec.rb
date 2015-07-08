require "rails_helper"

describe BusinessItemPhotoValidator do
  subject { BusinessItemPhotoValidator.new(product_photo_params) }

  let(:product_photo) { build(:product_photo) }

  include_context "photo validation", :product_photo, :photo
  include_context "photo validation", :service_photo, :photo
end

