@Sim.controller 'ProductsIndexCtrl', ['$scope', 'BusinessItemsLoader', 'ProductFactory',
  ($scope, BusinessItemsLoader, ProductFactory) ->
    BusinessItemsLoader.initialize(ProductFactory, $scope)

    $scope.showUrl = (businessitem) ->
      "product({ id: #{businessitem.get('id')} })"
]
