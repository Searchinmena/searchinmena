@Sim.controller 'ServiceCategoriesCtrl', ['$scope', 'CategoriesModal', '$modalInstance',
  ($scope, CategoriesModal, $modalInstance) ->
    CATEGORIES_PATH = "/service_categories"
    
    CategoriesModal.initialize($scope, CATEGORIES_PATH)

    $scope.ok = ->
      $modalInstance.close($scope.breadcrumbs)

    $scope.cancel = ->
      $modalInstance.dismiss('cancel')
]
