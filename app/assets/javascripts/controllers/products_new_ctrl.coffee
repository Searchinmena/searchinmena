@Sim.controller 'ProductsNewCtrl', ['$scope'
  ($scope) ->
    $scope.submit = (e) ->
      e.preventDefault()

      console.log($scope.form)

      false
]
