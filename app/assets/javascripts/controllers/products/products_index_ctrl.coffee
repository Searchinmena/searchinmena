@Sim.controller 'ProductsIndexCtrl', ['$scope', 'BusinessItemsLoader', 'ProductFactory',
  ($scope, BusinessItemsLoader, ProductFactory) ->
    BusinessItemsLoader.initialize(ProductFactory, $scope)

    $scope.showUrl = (businessItem) ->
      "product({ id: #{businessItem.get('id')} })"
]
