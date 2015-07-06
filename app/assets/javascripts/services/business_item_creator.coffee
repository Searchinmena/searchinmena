@Sim.service 'BusinessItemCreator', ['$rootScope', '$http', '$state'
  '$modal', 'TranslatedFlash', 'PhotosUploader',
  ($rootScope, $http, $state, $modal, TranslatedFlash,
    PhotosUploader) ->

    initialize: (scope, selectsLoader, resourceName) ->
      scope.form = {}
      scope.errors = {}
      scope.form.attributes = [new SIM.Attribute()]

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
          controller: 'CategoriesCtrl',
          animation: false,
          size: 'lg'
        )

        modalInstance.result.then(scope.setCategory)

      scope.setCategory = (breadcrumbs) ->
        scope.breadcrumbs = breadcrumbs
        scope.form ||= {}
        scope.form.product ||= {}
        scope.form.product.category_id = breadcrumbs.current().id

      scope.addAttribute = ->
        scope.form.attributes.push(new SIM.Attribute())

      scope.removeAttribute = (attribute) ->
        index = scope.form.attributes.indexOf(attribute)
        scope.form.attributes.splice(index, 1)

      scope.saveAndUploadPhotos = (photos) ->
        $http(
          url: "/#{resourceName}",
          data: scope.form,
          method: 'POST'
        ).success((data) ->
          itemId = data.id
          PhotosUploader.upload(photos, itemId,
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
        console.log(scope.form.attributes)

        # request photos from PhotosCtrl
        $rootScope.$broadcast("photos_request")

        false
]
