@Sim.controller 'ProductsNewCtrl', ['$scope', 'BusinessItemCreator', 'selectsLoader',
  ($scope, BusinessItemCreator, selectsLoader) ->
    RESOURCE_NAME = 'products'

    BusinessItemCreator.initialize($scope, selectsLoader, RESOURCE_NAME)
]
