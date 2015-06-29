@Sim.controller 'CategoriesCtrl', ['$scope', '$translate', '$http', 'language', '$modalInstance',
  ($scope, $translate, $http, language, $modalInstance) ->
    CATEGORIES_PATH = "/product_categories"

    $scope.loadBreadcrumbs = ->
      $translate("products.categories.choose").then((translation) ->
        $scope.breadcrumbs = new SIM.Breadcrumbs(translation)
      )

    $scope.level = 1

    $scope.loadCategoriesForParentId = (parentId, callback) ->
      params = { parent_id: parentId, locale: language.get() }
      $http.get(CATEGORIES_PATH, { params: params })
        .success((data) ->
          categories = for attributes in data
            new SIM.Category(attributes)

          callback(categories)
        )

    $scope.selectedCategory = null
    $scope.loadBreadcrumbs()
    $scope.loadCategoriesForParentId(null, (categories) ->
      $scope.categories = categories
    )

    $scope.previous = () ->
      $scope.deselectCategory()
      currentCategory = $scope.breadcrumbs.current()
      $scope.breadcrumbs.pop()
      $scope.loadCategoriesForParentId(currentCategory?.parentId, (categories) ->
        $scope.level -= 1
        $scope.updateCategories(categories)
      )

    $scope.next = (category) ->
      $scope.breadcrumbs.push(category)

      $scope.loadCategoriesForParentId(category.id, (categories) ->
        if categories.length > 0
          $scope.level += 1
          $scope.updateCategories(categories)
        else
          $scope.selectCategory(category)
      )

    $scope.updateCategories = (categories) ->
      for category in categories
        category.level = $scope.level

      $scope.categories = categories

    $scope.selectCategory = (category) ->
      category.selected = true
      $scope.selectedCategory = category

    $scope.deselectCategory = ->
      return unless $scope.selectedCategory

      $scope.selectedCategory.selected = false
      $scope.selectedCategory = null

    $scope.breadcrumbsWithoutLast = ->
      $scope.breadcrumbs.withoutLast()

    $scope.lastBreadcrumb = ->
      $scope.breadcrumbs.current()

    $scope.ok = ->
      $modalInstance.close($scope.selectedCategory)

    $scope.cancel = ->
      $modalInstance.dismiss('cancel')
]
