@Sim.controller 'ProductsNewCtrl', ['$scope', 'BusinessItemSaver',
  'ProductFactory', 'selectsLoader',
  ($scope, BusinessItemSaver, ProductFactory, selectsLoader) ->
    $scope.businessItem = ProductFactory.build()

    BusinessItemSaver.initialize(
      $scope, selectsLoader, ProductFactory.resourceName(),
      'ProductCategoriesCtrl')
]
