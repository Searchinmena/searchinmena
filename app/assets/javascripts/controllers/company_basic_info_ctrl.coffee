@Sim.controller 'CompanyBasicInfoCtrl', ['$scope', '$http', '$translate',
  'selectsLoader', 'TranslatedFlash'
  ($scope, $http, $translate, selectsLoader, TranslatedFlash) ->
    $scope.form = { business: {} }
    $scope.errors = {}

    config = {
      countries: "/countries",
      business_types: "/business_types"
    }

    selectsLoader.loadSelectsData($scope, config)

    $translate('company.basic_info.select_business_types').then((translation) ->
      $scope.selectButtonText = translation
    )

    $scope.loadTags = (query) ->
      $http.get(window.Sim.TAGS_PATH, params: { query: query })

    $scope.submit = (e) ->
      e.preventDefault()

      console.log($scope.form)

      $http(
        url: e.target.action,
        data: $scope.form,
        method: 'POST'
      ).success(->
        TranslatedFlash.success("company.successfully_added")
      ).error((errors) ->
        $scope.errors = errors
        TranslatedFlash.error("company.adding_failed")
      )

      false
]
