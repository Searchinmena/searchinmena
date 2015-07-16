@Sim.service 'BusinessItemCreator', ['$rootScope', '$http', '$state'
  '$modal', 'TranslatedFlash', 'PhotosUploader',
  ($rootScope, $http, $state, $modal, TranslatedFlash,
    PhotosUploader) ->

    initialize: (scope, selectsLoader, resourceName, photos_path, categoriesController) ->
      scope.form = {}
      scope.errors = {}
      scope.form.business_item ||= {}
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
          templateUrl: 'categories.html',
          controller: categoriesController,
          animation: false,
          size: 'lg'
        )

        modalInstance.result.then(scope.setCategory)

      scope.setCategory = (breadcrumbs) ->
        scope.breadcrumbs = breadcrumbs
        scope.form.business_item.category_id = breadcrumbs.current().id

      scope.addAttribute = ->
        scope.attributes.push(new SIM.Attribute())

      scope.removeAttribute = (attribute) ->
        index = scope.attributes.indexOf(attribute)
        scope.attributes.splice(index, 1)

      scope.saveAndUploadPhotos = (photos) ->
        scope.form.attributes = _(scope.attributes).filter((attribute) ->
          attribute.isPresent()
        )

        $http(
          url: "/#{resourceName}",
          data: scope.form,
          method: 'POST'
        ).success((data) ->
          itemId = data.id
          PhotosUploader.upload(photos_path, photos, itemId,
            ->
              TranslatedFlash.success("#{resourceName}.successfully_added")
              $state.go(resourceName)
            ,
            (errors) ->
              scope.errors.photos = errors
              TranslatedFlash.error("#{resourceName}.adding_failed")
          )
        ).error((errors) ->
          scope.errors = errors
          TranslatedFlash.error("#{resourceName}.adding_failed")
        )

      scope.$on("photos_response", (event, photos) ->
        scope.saveAndUploadPhotos(photos)
      )

      scope.submit = (e) ->
        e.preventDefault()
        scope.errors = {}

        # request photos from PhotosCtrl
        $rootScope.$broadcast("photos_request")

        false
]
