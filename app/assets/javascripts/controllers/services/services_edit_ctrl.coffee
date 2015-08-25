@Sim.controller 'ServicesEditCtrl', ['$scope', 'BusinessItemUpdater',
  'ServiceFactory', 'selectsLoader',
  ($scope, BusinessItemUpdater, ServiceFactory, selectsLoader) ->
    BusinessItemUpdater.initialize($scope, selectsLoader, ServiceFactory,
      'ServiceCategoriesCtrl')
]
