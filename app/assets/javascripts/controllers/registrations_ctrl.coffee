@Sim.controller 'RegistrationsCtrl', ['$scope', '$http', '$translate',
'selectsLoader',
  ($scope, $http, $translate, selectsLoader) ->
    config = {
      countries: '/countries',
      business_types: '/business_types'
    }

    selectsLoader.loadSelectsData($scope, config)

    $translate('company.basic_info.select_business_types').then((translation) ->
      $scope.selectButtonText = translation
    )

    $scope.init = (user_attributes) ->
      user_attributes = JSON.parse(user_attributes)

      $scope.form = {
        user: user_attributes || {},
        business: {}
      }

    $scope.shouldShowCompanyInfo = ->
      category = $scope.form.user.category
      category == 'seller' || category == 'both'

    $scope.isFacebookSignup = ->
      provider = $scope.form.user.provider
      provider == 'facebook'

    $scope.loadTags = (query) ->
      $http.get(window.Sim.TAGS_PATH, params: { query: query })

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
