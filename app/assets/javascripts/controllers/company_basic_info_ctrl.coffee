@Sim.controller 'CompanyBasicInfoCtrl', ['$scope', '$http',
  ($scope, $http) ->
    $scope.form = {}
    $scope.errors = {}

    $scope.loadTags = (query) ->
      $http.get("#{window.Sim.TAGS_PATH}?query=#{query}")

    $scope.submit = (e) ->
      e.preventDefault()

      console.log($scope.form)

      $http(
        url: e.target.action,
        data: $scope.form,
        method: 'POST'
      ).success(->
        console.log('SUCCESS')
      ).error((errors) ->
        console.log(errors)
        $scope.errors = errors
      )

      false
]
