@Sim.controller 'CompanyBasicInfoCtrl', ['$scope', '$http', '$translate',
  'selectsLoader',
  ($scope, $http, $translate, selectsLoader) ->
    $scope.form = { business:
      business_types: []
    }
    $scope.errors = { business: {
        name: "can't be blank",
        phone: "can't be blank",
        country: "can't be blank",
        business_types: "can't be blank"
      }
    }

    config = {
      countries: "/countries",
      business_types: "/business_types"
    }

    selectsLoader.loadSelectsData($scope, config)

    $scope.preselected_business_types = {}

    $translate('company.basic_info.select_business_types').then((translation) ->
      $scope.select_button_text = translation
    )

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
