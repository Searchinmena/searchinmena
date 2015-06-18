@Sim.controller 'ProductsNewCtrl', ['$scope', '$http', 'language',
  ($scope, $http, language) ->
    $scope.form = {}
    $scope.form.attributes = [new SIM.Attribute()]
    $scope.errors = {}

    @loadDataForSelect = (path, callback) ->
      $http.get(path, { params: { locale: language.get() } }).success(callback)

    @loadDataForSelect(window.Sim.UNITS_PATH, (data) ->
      $scope.units = data
    )
    @loadDataForSelect(window.Sim.CURRENCIES_PATH, (data) ->
      $scope.currencies = data
    )
    @loadDataForSelect(window.Sim.FREQUENCIES_PATH, (data) ->
      $scope.frequencies = data
    )
    @loadDataForSelect(window.Sim.PAYMENT_TERMS_PATH, (data) ->
      $scope.payment_terms = data
    )

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
