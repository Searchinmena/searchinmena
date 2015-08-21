@Sim.controller 'HomeCtrl', ['$scope', '$state', 'User', 'Search', 'SearchService',
  ($scope, $state, User, Search, SearchService) ->
    User.get((data) ->
      $scope.user = new User(data)
    )
    $scope.search = new Search(type: 'all')
    $scope.SearchService = SearchService

    $scope.submit = (e) ->
      e.preventDefault()
      $state.go("results", $scope.search.toParams())
]
