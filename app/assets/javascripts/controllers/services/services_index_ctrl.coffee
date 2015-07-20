@Sim.controller 'ServicesIndexCtrl', ['$scope', 'BusinessItemsLoader',
  ($scope, BusinessItemsLoader) ->
    RESOURCE_NAME = "services"

    BusinessItemsLoader.initialize(RESOURCE_NAME, $scope)

    $scope.showUrl = (businessitem) ->
      "service({ id: #{businessitem.get('id')} })"
]
