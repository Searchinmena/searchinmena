@Sim.factory 'ProductFactory', ['Product', (Product) ->
  build: (attributes) ->
    new Product(attributes)

  get: (params, successCallback, errorCallback) ->
    Product.get(params, successCallback, errorCallback)

  delete: (params, successCallback, errorCallback) ->
    Product.delete(params, successCallback, errorCallback)
]
