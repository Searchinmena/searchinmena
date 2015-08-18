@Sim.controller 'HomeCtrl', ['$scope', '$state', 'User', 'Search',
  ($scope, $state, User, Search) ->
    User.get((data) ->
      $scope.user = new User(data)
    )
    $scope.search = new Search()

    $scope.submit = (e) ->
      e.preventDefault()
      $state.go("results", $scope.search.toParams())
]
