@Sim.controller 'ProductsShowCtrl', ['$scope', '$stateParams',
  'BusinessItemLoader', 'ProductFactory', '$controller','SimilarItemsLoader', 'PrevItemLoader', 'NextItemLoader'
   'PRODUCT_SHOW_PATH',
  ($scope, $stateParams, BusinessItemLoader, ProductFactory, $controller, SimilarItemsLoader, PrevItemLoader, NextItemLoader, PRODUCT_SHOW_PATH) ->
    BusinessItemLoader.initialize(
      ProductFactory, $stateParams.id, $scope)
    SimilarItemsLoader.initialize(
        ProductFactory, $stateParams.id, $scope, PRODUCT_SHOW_PATH)
    PrevItemLoader.initialize(
        ProductFactory, $stateParams.id, $scope)
    NextItemLoader.initialize(
        ProductFactory, $stateParams.id, $scope)

    $controller('MetaCtrl').productMeta($stateParams.id)
]
