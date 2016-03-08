@Sim.controller 'ServicesNewCtrl', ['$scope', 'BusinessItemSaver',
  'ServiceFactory', 'TranslatedFlash', 'selectsLoader', '$location', '$http', 'USER_BUSINESS_PATH', 'DASHBOARD_PATH'
  ($scope, BusinessItemSaver, ServiceFactory, TranslatedFlash, selectsLoader, $location, $http, USER_BUSINESS_PATH, DASHBOARD_PATH) ->
    $http.get(USER_BUSINESS_PATH).success((businessAttributes) ->
      if businessAttributes.can_add_services
        $scope.businessItem = ServiceFactory.build()
        BusinessItemSaver.initialize(
          $scope, selectsLoader, ServiceFactory.resourceName(),
          'ServiceCategoriesCtrl')
      else
        $location.path(DASHBOARD_PATH);
        TranslatedFlash.error("services.limit")
    )
]

