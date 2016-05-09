@Sim.controller 'CategoriesCtrl', ['$scope' ,'$http','$stateParams','FetchCategories','CategoryLinks'
,'MAX_SUB_CATEGORIES_LENGTH',
($scope,$http,$stateParams,FetchCategories,CategoryLinks,MAX_SUB_CATEGORIES_LENGTH) ->
  $scope.max_sub_cat_length = MAX_SUB_CATEGORIES_LENGTH
  $scope.type = $stateParams.type
  $scope.categories = []

  CategoryLinks.setLinks($scope)

  FetchCategories.initialize($scope,$scope.path)

]
