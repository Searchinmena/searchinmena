@Sim.controller 'CategoriesForSearchCtrl', ['$scope', 'CategoriesModal', '$modalInstance', '$stateParams',
  ($scope, CategoriesModal, $modalInstance, $stateParams) ->
    #CATEGORIES_PATH = "/product_categories"
    $scope.category_path = (type) ->
      if type == 'product'
        path = "/product_categories"
      else
        path = "/service_categories"

      return path
    type = $stateParams.type
    CategoriesModal.initialize($scope, $scope.category_path(type))

    $scope.category_path('product')
    $scope.ok = ->
      $modalInstance.close($scope.breadcrumbs)

    $scope.cancel = ->
      $modalInstance.dismiss('cancel')
]