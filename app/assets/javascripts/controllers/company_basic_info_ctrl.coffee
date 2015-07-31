@Sim.controller 'CompanyBasicInfoCtrl', ['$scope', '$http', '$translate',
  'selectsLoader', 'TranslatedFlash', 'TAGS_PATH', 'USER_BUSINESS_PATH',
  'language'
  ($scope, $http, $translate, selectsLoader, TranslatedFlash, TAGS_PATH,
    USER_BUSINESS_PATH, language) ->

    config = {
      countries: '/countries',
      business_types: '/business_types'
    }

    selectsLoader.loadSelectsData($scope, config)

    $translate('company.basic_info.select_business_types').then((translation) ->
      $scope.selectButtonText = translation
    )

    $http.get(USER_BUSINESS_PATH).success((businessAttributes) ->
      $scope.form.business = businessAttributes
      $http.get('business_tags', { params: { business_id: businessAttributes.id, locale: language.get() } }).success((tags) ->
        $scope.form.business.tags = tags
      )
    )

    $scope.loadTags = (query) ->
      $http.get(TAGS_PATH, params: { query: query })

    $scope.submit = (e) ->
      e.preventDefault()

      $http(
        url: USER_BUSINESS_PATH,
        data: $scope.form,
        method: 'PUT'
      ).success(->
        $scope.errors = {}
        TranslatedFlash.success('company.successfully_saved')
      ).error((errors) ->
        $scope.errors = errors
        TranslatedFlash.error('company.saving_failed')
      )

      false
]
