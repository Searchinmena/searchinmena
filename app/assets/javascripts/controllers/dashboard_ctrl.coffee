@Sim.controller 'DashboardCtrl', ['$scope', 'CurrentUser',
  ($scope, CurrentUser) ->
    CurrentUser.authorize($scope)
]
