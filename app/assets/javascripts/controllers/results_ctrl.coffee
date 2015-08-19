@Sim.controller 'ResultsCtrl', ['$scope', '$state', '$stateParams',
  'Search', 'SearchService',
  ($scope, $state, $stateParams, Search, SearchService) ->
    $scope.search = new Search(type: $stateParams.type, query: $stateParams.query)
    
    $scope.viewOptionSelected = 'list-view'
    $scope.isNetViewSelected = ->
      $scope.viewOptionSelected == 'net-view'
    
    SearchService.perform($scope.search)

    $scope.submit = (e) ->
      e.preventDefault()
      $state.go("results", $scope.search.toParams())
]
