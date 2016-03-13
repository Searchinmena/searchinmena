@Sim.controller 'DashboardCtrl', ['$scope', 'CurrentUser', 'BusinessIsPremium',
  ($scope, CurrentUser, BusinessIsPremium) ->
    CurrentUser.authorize()
    $scope.currentUser = CurrentUser
    BusinessIsPremium.isPremium($scope)
]
