@Sim.controller 'ProductsEditCtrl', ['$scope', 'BusinessItemCreator',
  'ProductFactory', 'selectsLoader',
  ($scope, BusinessItemCreator, ProductFactory, selectsLoader) ->
    RESOURCE_NAME = 'products'

    BusinessItemCreator.initialize(
      $scope, selectsLoader, RESOURCE_NAME,
      'ProductCategoriesCtrl', ProductFactory)
]
