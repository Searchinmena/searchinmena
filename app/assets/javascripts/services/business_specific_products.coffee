@Sim.service 'BusinessSpecificProducts', ['ProductFactory', 'BUSINESSES_PATH', '$http', 'PRODUCT_SHOW_PATH',
  (ProductFactory, BUSINESSES_PATH, $http, PRODUCT_SHOW_PATH) ->
    initialize: (id, scope) ->
      $http.get(BUSINESSES_PATH + id).success((businessAttributes) ->
        #console.log businessAttributes
        # call fun to get product informaiton
        # return the array of current business product list
        dataLoaded(businessAttributes)

      )

      dataLoaded = (data) ->
        scope.business_products = for attributes in data.business_products
          ProductFactory.get({ id: attributes.id },
            (attributes) ->
              ProductFactory.buildPresenter(attributes)
          )
        scope.productshowpath = PRODUCT_SHOW_PATH;
]
