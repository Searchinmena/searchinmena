@Sim.controller 'ProductCategoriesCtrl', ['$scope', 'CategoriesModal', '$modalInstance',
  ($scope, CategoriesModal, $modalInstance) ->
    CATEGORIES_PATH = "/product_categories"
    
    CategoriesModal.initialize($scope, CATEGORIES_PATH)
]
