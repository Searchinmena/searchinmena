@Sim.service 'BusinessItemLoader', ['$http',
  ($http) ->
    initialize: (resourceName, id, scope) ->
      $http.get("/#{resourceName}/#{id}")
        .success((attributes) ->
          scope.businessItem = new SIM.BusinessItem(attributes)
        )
]
