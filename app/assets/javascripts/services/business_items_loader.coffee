@Sim.service 'BusinessItemsLoader', ['$http',
  ($http) =>
    initialize: (path, scope) ->
      scope.businessItems = []
      scope.total = 0
      scope.perPage = 10
      scope.pagination = {
        current: 1
      }

      scope.pageChanged = (newPage) ->
        $http.get(path, params: { page: newPage })
          .success((data) ->
            scope.businessItems = for attributes in data.items
              new SIM.BusinessItem(attributes)
            scope.total = data.count
          )

      scope.pageChanged(1)
]
