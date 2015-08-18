@Sim.controller 'ResultsCtrl', ['$scope', '$stateParams', 'Search', 'SearchService',
  ($scope, $stateParams, Search, SearchService) ->
    console.log($stateParams)
    $scope.search = new Search(type: $stateParams.type, query: $stateParams.query)
    console.log($scope.search)
    
    SearchService.perform($scope.search)

    $scope.browseFilterSelected = (type) ->
      $scope.search.type == type || !$scope.search.type && type == "all"

    $scope.submit = (e) ->
      e.preventDefault()
      SearchService.perform($scope.search)
]
