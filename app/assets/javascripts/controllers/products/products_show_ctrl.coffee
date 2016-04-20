@Sim.controller 'ProductsShowCtrl', ['$scope', '$stateParams',
  'BusinessItemLoader', 'ProductFactory', '$controller','SimilarItemsLoader',
   'PRODUCT_SHOW_PATH',
  ($scope, $stateParams, BusinessItemLoader, ProductFactory, $controller, SimilarItemsLoader,PRODUCT_SHOW_PATH) ->
    BusinessItemLoader.initialize(
      ProductFactory, $stateParams.id, $scope)
    SimilarItemsLoader.initialize(
        ProductFactory, $stateParams.id, $scope, PRODUCT_SHOW_PATH)
    $controller('MetaCtrl').productMeta($stateParams.id)
]
