@Sim.controller 'ProductsNewCtrl', ['$scope', 'BusinessItemCreator',
  'ProductFactory', 'selectsLoader',
  ($scope, BusinessItemCreator, ProductFactory, selectsLoader) ->
    RESOURCE_NAME = 'products'
    PHOTOS_PATH = '/product_photos'

    BusinessItemCreator.initialize(
      $scope, selectsLoader, RESOURCE_NAME, PHOTOS_PATH,
      'ProductCategoriesCtrl', ProductFactory)
]
