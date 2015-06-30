@Sim.controller 'RegistrationsCtrl', ['$scope', '$http',
  ($scope, $http) ->
    $scope.init = (user_attributes) ->
      user_attributes = JSON.parse(user_attributes)

      $scope.form = { user: user_attributes || {}, business: {} }

    $scope.shouldShowCompanyInfo = ->
      category = $scope.form.user.category
      category == "seller" || category == "both"

    $scope.isFacebookSignup = ->
      provider = $scope.form.user.provider
      provider == "facebook"

    $scope.loadTags = (query) ->
      $http.get("#{window.Sim.TAGS_PATH}?query=#{query}")

    $scope.submit = (e) ->
      e.preventDefault()

      $http(
        url: e.target.action,
        data: $scope.form,
        method: 'POST'
      ).success(->
        window.location = window.Sim.DASHBOARD_PATH
      ).error((errors) ->
        $scope.errors = errors
      )

      false
]
