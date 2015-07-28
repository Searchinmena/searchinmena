@Sim.service 'BusinessItemsLoader', [
  ->
    initialize: (businessItemFactory, scope) ->
      scope.businessItems = []
      scope.total = 0
      scope.perPage = Config.itemsPerPage
      scope.pagination = {
        current: 1
      }

      scope.assignData = (data) ->
        scope.businessItems = for attributes in data.items
          new SIM.BusinessItem(attributes)
        scope.total = data.count

      scope.pageChanged = (newPage) ->
        businessItemFactory.get({ page: newPage }, scope.assignData)

      scope.pageChanged(1)

      scope.deleteClicked = (businessItem) ->
        params = { id: businessItem.get('id'), page: scope.pagination.current }
        businessItemFactory.delete(params, scope.assignData)
]
