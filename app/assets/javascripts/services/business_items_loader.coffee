@Sim.service 'BusinessItemsLoader', ['$http',
  ($http) =>
    initialize: (resourceName, scope) ->
      scope.businessItems = []
      scope.total = 0
      scope.perPage = 10
      scope.pagination = {
        current: 1
      }

      scope.assignData = (data) ->
        scope.businessItems = for attributes in data.items
          new SIM.BusinessItem(attributes)
        scope.total = data.count

      scope.pageChanged = (newPage) ->
        $http.get("/#{resourceName}", params: { page: newPage })
          .success(scope.assignData)

      scope.pageChanged(1)

      scope.deleteClicked = (e, businessItem) ->
        e.preventDefault()

        $http.delete("/#{resourceName}/#{businessItem.get('id')}",
          params: { page: scope.pagination.current })
            .success(scope.assignData)
]
