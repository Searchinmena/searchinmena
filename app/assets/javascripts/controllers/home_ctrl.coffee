@Sim.controller 'HomeCtrl', ['$scope', 'User', 'Search',
  ($scope, User, Search) ->
    User.get((data) ->
      $scope.user = new User(data)
    )
    $scope.search = new Search()

    $scope.submit = (e) ->
      e.preventDefault()
      $scope.search.$save()
]
