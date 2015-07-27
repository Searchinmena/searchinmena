@Sim.service 'BusinessItemCreator', ['$rootScope', '$http', '$state'
  '$modal', 'TranslatedFlash', 'PhotosUploader',
  ($rootScope, $http, $state, $modal, TranslatedFlash,
    PhotosUploader) ->

    initialize: (scope, selectsLoader, resourceName, photos_path, categoriesController, businessItemFactory) ->
      scope.businessItem = businessItemFactory.build()
      scope.errors = {}
      scope.attributes = (new SIM.Attribute() for i in [0..1])

      config = {
        units: "/units",
        currencies: "/currencies",
        frequencies: "/frequencies",
        payment_terms: "/payment_terms"
      }

      selectsLoader.loadSelectsData(scope, config)

      scope.showCategories = ->
        modalInstance = $modal.open(
          templateUrl: 'business_items/categories.html',
          controller: categoriesController,
          animation: false,
          size: 'lg'
        )

        modalInstance.result.then(scope.setCategory)

      scope.setCategory = (breadcrumbs) ->
        scope.breadcrumbs = breadcrumbs
        scope.businessItem.category_id = breadcrumbs.current().id

      scope.addAttribute = ->
        scope.attributes.push(new SIM.Attribute())

      scope.removeAttribute = (attribute) ->
        index = scope.attributes.indexOf(attribute)
        scope.attributes.splice(index, 1)

      scope.saveSucceededCallback = (data, photos) ->
        itemId = data.id
        PhotosUploader.upload(photos_path, photos, itemId,
          ->
            TranslatedFlash.success("#{resourceName}.successfully_added")
            $state.go("dashboard.#{resourceName}")
          , (errors) ->
            scope.loading = false
            scope.errors.photos = errors
            scope.showFlashError()
        )

      scope.showFlashError = ->
        TranslatedFlash.error("#{resourceName}.adding_failed")
        scope.loading = false

      scope.saveAndUploadPhotos = (photos) ->
        scope.businessItem.breadcrumbs = _(scope.attributes).filter((attribute) ->
          attribute.isPresent()
        )

        scope.businessItem.$save(
          (data) ->
            scope.saveSucceededCallback(data, photos)
          , (response) ->
            scope.loading = false
            scope.errors = response["data"]
            scope.showFlashError()
        )

      scope.$on("photos_response", (event, photos) ->
        scope.saveAndUploadPhotos(photos)
      )

      scope.submit = (e) ->
        e.preventDefault()
        scope.loading = true
        scope.errors = {}

        # request photos from PhotosCtrl
        $rootScope.$broadcast("photos_request")

        false
]
