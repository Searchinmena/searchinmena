@Sim.controller 'ProductsNewCtrl', ['$scope', '$http',
  ($scope, $http) ->
    $scope.form = {}
    $scope.form.attributes = [new SIM.Attribute()]
    $scope.errors = { product: {
      name: "can't be blank",
      category: "can't be blank",
      photos: "can't be blank",
      description: "too long",
      model_number: "too long",
      brand_name: "too long",
      min_order_quantity_number: "not a number",
      fob_price: "not a number",
      supply_ability_capacity: "not a number",
      port: "too long",
      packaging: "too long"
    } }

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
