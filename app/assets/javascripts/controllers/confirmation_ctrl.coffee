@Sim.controller 'ConfirmationCtrl', ['$scope', '$modalInstance',
  ($scope, $modalInstance) ->
    $scope.ok = ->
      $modalInstance.close()

    $scope.cancel = ->
      $modalInstance.dismiss('cancel')
]
