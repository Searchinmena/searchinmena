@Sim.controller 'CompanyBasicInfoCtrl', ['$scope', '$http', '$translate',
  'selectsLoader', 'TranslatedFlash'
  ($scope, $http, $translate, selectsLoader, TranslatedFlash) ->
    $scope.errors = {}

    config = {
      countries: "/countries",
      business_types: "/business_types"
    }

    selectsLoader.loadSelectsData($scope, config)

    $translate('company.basic_info.select_business_types').then((translation) ->
      $scope.selectButtonText = translation
    )

    $http.get('business').success((businessAttributes) ->
      $scope.form.business = businessAttributes
    ).error(->
      $scope.form.business = { business: {} }
    )

    $scope.loadTags = (query) ->
      $http.get(window.Sim.TAGS_PATH, params: { query: query })

    $scope.submit = (e) ->
      e.preventDefault()

      $http(
        url: e.target.action,
        data: $scope.form,
        method: 'PUT'
      ).success(->
        TranslatedFlash.success("company.successfully_saved")
      ).error((errors) ->
        $scope.errors = errors
        TranslatedFlash.error("company.saving_failed")
      )

      false
]
