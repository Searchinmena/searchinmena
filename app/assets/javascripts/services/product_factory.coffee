@Sim.factory 'ProductFactory', ['Product', 'ProductPresenter','SimilarProducts',
  (Product, ProductPresenter,SimilarProducts) ->
    resourceName: ->
      'products'

    build: (attributes) ->
      new Product(attributes)

    buildPresenter: (attributes) ->
      new ProductPresenter(attributes)

    get: (params, successCallback, errorCallback) ->
      Product.get(params, successCallback, errorCallback)

    get_similar: (params, successCallback, errorCallback) ->
      SimilarProducts.get(params, successCallback, errorCallback)

    delete: (params, successCallback, errorCallback) ->
      Product.delete(params, successCallback, errorCallback)

    indexPath: ->
      "dashboard.products"
]
