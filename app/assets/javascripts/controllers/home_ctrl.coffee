@Sim.controller 'HomeCtrl', ['$scope', 'User',
  ($scope, User) ->
    User.get((data) ->
      $scope.user = new User(data)
    )
]
