@Sim.factory 'ProductFactory', ['Product', 'ProductPresenter',
  (Product, ProductPresenter) ->
    resourceName: ->
      'products'

    build: (attributes) ->
      new Product(attributes)

    buildPresenter: (attributes) ->
      new ProductPresenter(attributes)

    get: (params, successCallback, errorCallback) ->
      Product.get(params, successCallback, errorCallback)

    delete: (params, successCallback, errorCallback) ->
      Product.delete(params, successCallback, errorCallback)

    indexPath: ->
      "dashboard.products"
]
