@Sim.controller 'ResultsCtrl', ['$scope', '$state', '$stateParams',
  'Search', 'SearchService', 'ResultPresenterFactory', 'selectsLoader', 'MessageModal', 'ITEMS_PER_PAGE',
                                'CategoriesModal', '$modal', '$controller', 'ShowPhoneNumber',
  ($scope, $state, $stateParams, Search, SearchService,
  ResultPresenterFactory, selectsLoader, MessageModal, ITEMS_PER_PAGE, CategoriesModal, $modal, $controller, ShowPhoneNumber) ->

    $scope.search = new Search(
      type: $stateParams.type,
      query: $stateParams.query,
      business_type: $stateParams.business_type,
      country: $stateParams.country,
      category: $stateParams.category,
      page: $stateParams.page,
      viewOption: $stateParams.viewOption
    )

    $scope.showPhoneNumber = false
    $scope.showPhone = () ->
      $scope.showPhoneNumber = true

    # add meta
    $controller('MetaCtrl').resultPage($stateParams.type)

    config = {
      countries: '/countries',
      business_types: '/business_types'
    }

    selectsLoader.loadSelectsData($scope, config)

    $scope.showCategories = ->
      modalInstance = $modal.open(
        templateUrl: 'business_items/categories.html',
        controller: 'CategoriesForSearchCtrl',
        animation: false,
        size: 'lg'
      )
      modalInstance.result.then($scope.setCategory)

    $scope.setCategory = (breadcrumbs) ->
      $scope.breadcrumbs = breadcrumbs
      $scope.search.category = breadcrumbs.current().id

    $scope.MessageModal = MessageModal

    $scope.perPage = ITEMS_PER_PAGE
    $scope.pagination = {
      current: $stateParams.page
    }

    $scope.search.viewOption = $stateParams.viewOption || 'list-view'
    $scope.isNetViewSelected = ->
      $scope.search.viewOption == 'net-view'

    $scope.dataLoaded = (data) ->
      $scope.results = for resultData in data.items
        ResultPresenterFactory.build(resultData)
      $scope.total = data.count

    SearchService.perform($scope.search.toParams(), $scope.dataLoaded)

    $scope.reloadPage = ->
      $state.go("results", $scope.search.toParams())

    $scope.pageChanged = (newPage) ->
      $scope.search.page = newPage
      $scope.reloadPage()

    $scope.submit = (e) ->
      e.preventDefault()
      $scope.search.page = 1
      $scope.reloadPage()

    $scope.searchFilter = (type) ->
      if $scope.search.type == 'business'
        $scope.showBusinessFilter = true
    $scope.searchFilter($scope.search.type)
]
