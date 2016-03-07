@Sim.controller 'ServicesIndexCtrl', ['$scope', 'BusinessItemsLoader', 'ServiceFactory', '$http', 'USER_BUSINESS_PATH',
  ($scope, BusinessItemsLoader, ServiceFactory, $http, USER_BUSINESS_PATH) ->
    $http.get(USER_BUSINESS_PATH).success((businessAttributes) ->
      $scope.business = businessAttributes
      BusinessItemsLoader.initialize(ServiceFactory, $scope)
    )  
]
