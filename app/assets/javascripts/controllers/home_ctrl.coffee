@Sim.controller 'HomeCtrl', ['$scope', '$state', 'User', 'Search', 'SearchService',
                             '$controller',
  ($scope, $state, User, Search, SearchService, $controller) ->

    $controller('MetaCtrl').homeMeta()

    User.get((data) ->
      $scope.user = new User(data)
    )
    $scope.search = new Search(type: 'all')
    $scope.SearchService = SearchService

    $scope.submit = (e) ->
      e.preventDefault()
      $state.go("results", $scope.search.toParams())
]
