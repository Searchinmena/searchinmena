@Sim.service 'BusinessItemsLoader', ['ITEMS_PER_PAGE', 'BusinessItemPresenter',
  '$state', '$stateParams'
  (ITEMS_PER_PAGE, BusinessItemPresenter, $state, $stateParams) ->
    initialize: (businessItemFactory, scope) ->
      scope.perPage = ITEMS_PER_PAGE
       
      scope.pagination = {
        current: $stateParams.page
      }

      scope.dataLoaded = (data) ->
        scope.businessItems = for attributes in data.items
          businessItemFactory.buildPresenter(attributes)
        scope.total = data.count

      scope.reloadPage = ->
        businessItemFactory.get({ page: $stateParams.page }, scope.dataLoaded)

      scope.reloadPage()

      scope.pageChanged = (newPage) ->
        $state.go(businessItemFactory.indexPath(), { page: newPage })

      scope.deleteClicked = (businessItem) ->
        params = { id: businessItem.get('id'), page: scope.pagination.current }
        businessItemFactory.delete(params, scope.reloadPage)
        window.location.reload()
]
