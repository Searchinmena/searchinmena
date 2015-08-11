@Sim.controller 'RegistrationsCtrl', ['$scope', '$http', '$translate',
'selectsLoader', 'DASHBOARD_PATH', 'TAGS_PATH'
  ($scope, $http, $translate, selectsLoader, DASHBOARD_PATH, TAGS_PATH) ->
    config = {
      countries: '/countries',
      business_types: '/business_types'
    }

    selectsLoader.loadSelectsData($scope, config)

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
      $http.get(TAGS_PATH, params: { query: query })

    $scope.submit = (e) ->
      e.preventDefault()
      unless $scope.loading
        $scope.loading = true

        $http(
          url: e.target.action,
          data: $scope.form,
          method: 'POST'
        ).success(->
          window.location = DASHBOARD_PATH
        ).error((errors) ->
          $scope.errors = errors
        ).then(
          $scope.loading = false
        )
      false
]
