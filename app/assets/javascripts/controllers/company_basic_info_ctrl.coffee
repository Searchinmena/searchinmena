@Sim.controller 'CompanyBasicInfoCtrl', ['$scope', '$http', 'selectsLoader',
  ($scope, $http, selectsLoader) ->
    $scope.form = {}
    $scope.errors = { business: {
        name: "can't be blank",
        phone: "can't be blank",
        country: "can't be blank",
        business_type: "can't be blank"
      }
    }

    config = {
      countries: "/countries",
      business_types: "/business_types"
    }

    selectsLoader.loadSelectsData($scope, config)

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
