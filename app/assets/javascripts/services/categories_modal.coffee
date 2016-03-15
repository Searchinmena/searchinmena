@Sim.service 'CategoriesModal', ['$translate', '$http', 'language', '$location',
  ($translate, $http, language, $location) ->

    initialize: (scope, path) ->
      scope.loadBreadcrumbs = ->
        $translate("categories_modal.choose").then((translation) ->
          scope.breadcrumbs = new SIM.Breadcrumbs(translation)
        )

      scope.level = 1

      scope.loadCategoriesForParentId = (parentId, callback) ->
        params = { parent_id: parentId, locale: language.get() }
        $http.get(path, { params: params })
          .success((data) ->
            categories = for attributes in data
              new SIM.Category(attributes)

            callback(categories)
          )

      scope.selectedCategory = null
      scope.loadBreadcrumbs()
      scope.loadCategoriesForParentId(null, (categories) ->
        scope.categories = categories
      )

      scope.previous = () ->
        currentCategory = scope.breadcrumbs.current()
        scope.breadcrumbs.pop()

        if scope.selectedCategory
          scope.deselectCategory()
          return

        scope.loadCategoriesForParentId(currentCategory?.parentId, (categories) ->
          scope.level -= 1
          scope.updateCategories(categories)
        )

      scope.next = (category) ->
        currentCategory = scope.breadcrumbs.current()
        if currentCategory && currentCategory.level == category.level
          return

        scope.breadcrumbs.push(category)

        scope.loadCategoriesForParentId(category.id, (categories) ->
          if $location.path() == '/results'
            max_level = 2
          else
            max_level = 4
          if categories.length > 0 && scope.level < max_level
            scope.level += 1
            scope.updateCategories(categories)
          else
            scope.selectCategory(category)
        )

      scope.updateCategories = (categories) ->
        for category in categories
          category.level = scope.level

        scope.categories = categories

      scope.selectCategory = (category) ->
        category.selected = true
        scope.selectedCategory = category

      scope.deselectCategory = ->
        return unless scope.selectedCategory

        scope.selectedCategory.selected = false
        scope.selectedCategory = null
  ]
