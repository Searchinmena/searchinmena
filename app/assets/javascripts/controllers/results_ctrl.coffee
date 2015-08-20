@Sim.controller 'ResultsCtrl', ['$scope', '$state', '$stateParams',
  'Search', 'SearchService', 'ResultPresenterFactory', 'MessageModal',
  ($scope, $state, $stateParams, Search, SearchService,
  ResultPresenterFactory, MessageModal) ->
    $scope.search = new Search(type: $stateParams.type, query: $stateParams.query)
    $scope.MessageModal = MessageModal
    
    $scope.viewOptionSelected = 'list-view'
    $scope.isNetViewSelected = ->
      $scope.viewOptionSelected == 'net-view'
    
    $scope.dataLoaded = (data) ->
      $scope.results = _(data).map((resultData) ->
        ResultPresenterFactory.build(resultData)
      )

    SearchService.perform($scope.search.toParams(), $scope.dataLoaded)

    $scope.submit = (e) ->
      e.preventDefault()
      $state.go("results", $scope.search.toParams())
]
