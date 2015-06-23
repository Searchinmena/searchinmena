require 'rails_helper'

describe ProductPhotoValidator do
  subject { ProductPhotoValidator.new(product_photo_params) }

  let(:product_photo) { build(:product_photo) }

  include_context "photo validation", :product_photo, :photo
end

