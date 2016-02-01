@Sim.controller 'ResultsCtrl', ['$scope', '$state', '$stateParams',
  'Search', 'SearchService', 'ResultPresenterFactory', 'MessageModal', 'ITEMS_PER_PAGE',
  '$controller',
  ($scope, $state, $stateParams, Search, SearchService,
  ResultPresenterFactory, MessageModal, ITEMS_PER_PAGE, $controller) ->
    $scope.search = new Search(
      type: $stateParams.type,
      query: $stateParams.query,
      page: $stateParams.page,
      viewOption: $stateParams.viewOption
    )
    # add meta
    $controller('MetaCtrl').resultPage($stateParams.type)
    $scope.MessageModal = MessageModal

    $scope.perPage = ITEMS_PER_PAGE
    $scope.pagination = {
      current: $stateParams.page
    }
    
    $scope.search.viewOption = $stateParams.viewOption || 'list-view'
    $scope.isNetViewSelected = ->
      $scope.search.viewOption == 'net-view'
    
    $scope.dataLoaded = (data) ->
      $scope.results = for resultData in data.items
        ResultPresenterFactory.build(resultData)
      $scope.total = data.count

    SearchService.perform($scope.search.toParams(), $scope.dataLoaded)

    $scope.reloadPage = ->
      $state.go("results", $scope.search.toParams())

    $scope.pageChanged = (newPage) ->
      $scope.search.page = newPage
      $scope.reloadPage()

    $scope.submit = (e) ->
      e.preventDefault()
      $scope.reloadPage()
]
