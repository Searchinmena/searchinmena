@Sim.controller 'CategoriesCtrl', ['$scope' ,'$http','$stateParams','FetchCategories','CategoryLinks'
,'MAX_SUB_CATEGORIES_LENGTH', 'MetaService',
($scope,$http,$stateParams,FetchCategories,CategoryLinks,MAX_SUB_CATEGORIES_LENGTH, MetaService) ->

  # Set meta tags
  if $stateParams.type == 'product'
    itemTitle = 'Find trusted supplier to source products & samples'
    itemDescription = 'Find the trusted supplier and source products and samples from Saudi Arabia, UAE, Turkey, Egypt, Morocco and other Middle East & North Africa countries'
    itemKeywords = 'Trusted, supplier, source, products, order, samples, Saudi Arabia, UAE, Turkey, Egypt, Morocco, Middle East, North Africa'
  else
    itemTitle = 'Connect with businesses & buy high quality of services'
    itemDescription = 'Connect with the best business providers & buy high quality of services in Saudi Arabia, UAE, Turkey, Egypt, Morocco & other Middle East & North Africa countries'
    itemKeywords = 'Business providers, buy, order, services, Saudi Arabia, UAE, Turkey, Egypt, Morocco, Middle East, North Africa'

  MetaService.set itemTitle, itemDescription, itemKeywords

  $scope.max_sub_cat_length = MAX_SUB_CATEGORIES_LENGTH
  $scope.type = $stateParams.type
  $scope.categories = []

  CategoryLinks.setLinks($scope)

  FetchCategories.initialize($scope,$scope.path)

]
