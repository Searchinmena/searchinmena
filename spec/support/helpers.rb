def build_params(model, params = {})
  params = model.attributes.symbolize_keys.merge(params)
  params.delete(:id)
  params
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
