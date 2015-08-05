@Sim.controller 'CompanyShowCtrl', ['$scope', '$http', '$stateParams',
  'CompanyPresenter', 'language'
  ($scope, $http, $stateParams, CompanyPresenter, language) ->
  
    params = {
      params: {
        business_id: $stateParams.id,
        locale: language.get()
      }
    }

    $http.get('businesses/' + $stateParams.id).success((businessAttributes) ->
      $http.get('business_tags', params).success((tags) ->
        $http.get('business_types', params).success((types) ->
          $scope.businessPresenter = new CompanyPresenter(businessAttributes, tags, types)
        )
      )
    )
]
