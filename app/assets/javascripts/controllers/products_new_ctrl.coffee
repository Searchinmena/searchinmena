@Sim.controller 'ProductsNewCtrl', ['$scope', '$http',
  ($scope, $http) ->
    $scope.form = {}
    $scope.form.attributes = [new SIM.Attribute()]

    $scope.addAttribute = ->
      $scope.form.attributes.push(new SIM.Attribute())

    $scope.removeAttribute = (attribute) ->
      index = $scope.form.attributes.indexOf(attribute)
      $scope.form.attributes.splice(index, 1)

    $scope.submit = (e) ->
      e.preventDefault()

      console.log($scope.form)

      $http(
        url: e.target.action,
        data: $scope.form,
        method: 'POST'
      ).success(->
        console.log("SUCCESS")
      ).error((errors) ->
        console.log(errors)
        $scope.errors = errors
      )

      false
]
