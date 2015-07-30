def build_params(model, params = {})
  params = model.attributes.symbolize_keys.merge(params)
  [:id, :created_at, :updated_at].each { |attr| params.delete(attr) }
  params
end

def build_business_params(business, business_type_ids = [], params = {})
  params = build_params(business, params)
  params.merge(business_type_ids: business_type_ids)
end

def build_user_params(user, params = {})
  params = build_params(user, params)
  category = User.categories.key(params[:category])
  params.merge(
    password: user.password,
    password_confirmation: user.password_confirmation,
    category: category
  )
end

def test_image(name: 'test-image.png', content_type: nil)
  content_type ||= PhotoValidator::VALID_CONTENT_TYPES.first
  path = File.join(Rails.root, 'spec', 'support', 'fixtures', name)
  Rack::Test::UploadedFile.new(path, content_type)
end
