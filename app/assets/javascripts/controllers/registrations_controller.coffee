@Sim.controller 'RegistrationsCtrl', ['$scope', '$http',
  ($scope, $http) ->
    $scope.shouldShowCompanyInfo = ->
      category = $scope.form.user.category
      category == "seller" || category == "both"

    $scope.form = { user: {}, business: {}}
    $scope.form.business.tags = [
      { name: 'just' },
      { name: 'some' },
      { name: 'cool' },
      { name: 'tags' }
    ]

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
        $scope.form.errors = errors
      )
      
      false
]
