@Sim.controller 'BusinessShowCtrl', ['$scope', '$http', '$stateParams',
  'BusinessPresenter', 'language', 'BUSINESSES_PATH', 'BUSINESS_TYPES_PATH',
  'BUSINESS_TAGS_PATH', 'MessageModal', 'BusinessSpecificProducts', 'BusinessSpecificServices',
  ($scope, $http, $stateParams, BusinessPresenter, language,
    BUSINESSES_PATH, BUSINESS_TYPES_PATH, BUSINESS_TAGS_PATH, MessageModal, BusinessSpecificProducts, BusinessSpecificServices) ->
    params = {
      params: {
        business_id: $stateParams.id,
        locale: language.get()
      }
    }

    $http.get(BUSINESSES_PATH + $stateParams.id).success((businessAttributes) ->
      $http.get(BUSINESS_TAGS_PATH, params).success((tags) ->
        $http.get(BUSINESS_TYPES_PATH, params).success((types) ->
          $scope.businessPresenter = new BusinessPresenter(businessAttributes, tags, types)
          $controller('MetaCtrl').businessMeta($scope.businessPresenter)
        )
      )
    )

    BusinessSpecificProducts.initialize(
      $stateParams.id, $scope)

    BusinessSpecificServices.initialize(
      $stateParams.id, $scope)

    $scope.MessageModal = MessageModal
]
