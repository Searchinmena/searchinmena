@Sim.controller 'BusinessBasicInfoCtrl', ['$scope', '$http', '$translate',
  'selectsLoader', 'TranslatedFlash', 'TAGS_PATH', 'USER_BUSINESS_PATH',
  'language', 'CurrentUser',
  ($scope, $http, $translate, selectsLoader, TranslatedFlash, TAGS_PATH,
    USER_BUSINESS_PATH, language, CurrentUser) ->

    config = {
      countries: '/countries',
      business_types: '/business_types'
    }

    tags_params = (business_id) -> {
      params: {
        business_id: business_id,
        locale: language.get()
      }
    }

    selectsLoader.loadSelectsData($scope, config)

    $http.get(USER_BUSINESS_PATH).success((businessAttributes) ->
      $scope.form.business = businessAttributes

      $http.get('business_tags', tags_params(businessAttributes.id)).success((tags) ->
        $scope.form.tags = tags
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
        # reauthorize user to show correct menu
        CurrentUser.authorize()

        $scope.errors = {}
        TranslatedFlash.success('business.successfully_saved')
      ).error((errors) ->
        $scope.errors = errors
        TranslatedFlash.error('business.saving_failed')
      )

      false
]
