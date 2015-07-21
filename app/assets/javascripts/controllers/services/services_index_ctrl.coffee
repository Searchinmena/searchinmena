@Sim.controller 'ServicesIndexCtrl', ['$scope', 'BusinessItemsLoader', 'ServiceFactory',
  ($scope, BusinessItemsLoader, ServiceFactory) ->
    BusinessItemsLoader.initialize(ServiceFactory, $scope)

    $scope.showUrl = (businessitem) ->
      "service({ id: #{businessitem.get('id')} })"
]
