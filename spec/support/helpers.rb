def build_params(model, params = {})
  params = model.attributes.symbolize_keys.merge(params)
  params.delete(:id)
  params
end
