@Sim.service 'BusinessSpecificServices', ['ServiceFactory', 'BUSINESSES_PATH', '$http',
  (ServiceFactory, BUSINESSES_PATH, $http) ->
    initialize: (id, scope) ->
      $http.get(BUSINESSES_PATH + id).success((businessAttributes) ->
        #console.log businessAttributes
        # call fun to get product informaiton
        # return the array of current business product list
        dataLoaded(businessAttributes)

      )

      dataLoaded = (data) ->
        scope.business_services = for attributes in data.business_services
          ServiceFactory.get({ id: attributes.id },
            (attributes) ->
              ServiceFactory.buildPresenter(attributes)
          )
]
