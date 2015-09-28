@Sim.service 'BusinessSpecificProducts', ['ProductFactory', 'BUSINESSES_PATH', '$http',
  (ProductFactory, BUSINESSES_PATH, $http) ->
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
]
