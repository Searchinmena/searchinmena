@Sim.controller 'ProductsEditCtrl', ['$scope', 'BusinessItemUpdater',
  'ProductFactory', 'selectsLoader',
  ($scope, BusinessItemUpdater, ProductFactory, selectsLoader) ->
    BusinessItemUpdater.initialize($scope, selectsLoader, ProductFactory,
      'ProductCategoriesCtrl')
]
