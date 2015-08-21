@Sim.service 'BusinessItemsLoader', ['ITEMS_PER_PAGE', 'BusinessItemPresenter',
  (ITEMS_PER_PAGE, BusinessItemPresenter) ->
    initialize: (businessItemFactory, scope) ->
      scope.perPage = ITEMS_PER_PAGE
      scope.pagination = {
        current: 1
      }

      scope.assignData = (data) ->
        scope.businessItems = for attributes in data.items
          businessItemFactory.buildPresenter(attributes)
        scope.total = data.count

      scope.pageChanged = (newPage) ->
        businessItemFactory.get({ page: newPage }, scope.assignData)

      scope.pageChanged(1)

      scope.deleteClicked = (businessItem) ->
        params = { id: businessItem.get('id'), page: scope.pagination.current }
        businessItemFactory.delete(params, scope.assignData)
]
