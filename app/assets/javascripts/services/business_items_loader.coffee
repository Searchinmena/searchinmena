@Sim.service 'BusinessItemsLoader', ['$http',
  ($http) ->
    load: (path, scope) ->
      $http.get(path)
        .success((data) ->
          scope.businessItems = for attributes in data
            new SIM.BusinessItem(attributes)
        )
]
