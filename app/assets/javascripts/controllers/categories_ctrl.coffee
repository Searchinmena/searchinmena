@Sim.controller 'CategoriesCtrl', ['$scope' ,'$http','$stateParams','FetchCategories','CategoryLinks',
($scope,$http,$stateParams,FetchCategories,CategoryLinks) ->
  
  $scope.type = $stateParams.type
  $scope.categories = []

  CategoryLinks.setLinks($scope)

  FetchCategories.initialize($scope,$scope.path)

]
