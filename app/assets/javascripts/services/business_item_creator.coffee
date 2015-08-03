@Sim.service 'BusinessItemCreator', ['$rootScope', '$http', '$state'
  '$modal', 'TranslatedFlash', 'PhotosUploader', 'Upload', 'PhotosValidator', 'AttributesErrors',
  ($rootScope, $http, $state, $modal, TranslatedFlash,
    PhotosUploader, Upload, PhotosValidator, AttributesErrors) ->

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

      scope.removePhoto = (photo) ->
        index = scope.businessItem.photos.indexOf(photo)
        scope.businessItem.photos.splice(index, 1)

      scope.saveSucceededCallback = ->
        TranslatedFlash.success("#{resourceName}.successfully_added")
        $state.go("dashboard.#{resourceName}")

      scope.showFlashError = ->
        TranslatedFlash.error("#{resourceName}.adding_failed")
        scope.loading = false

      scope.saveAndUploadPhotos = ->
        photos = scope.businessItem.photos

        attributes = _(scope.attributes).filter((attribute) ->
          attribute.isPresent()
        ).map((attribute) ->
          delete attribute['$$hashKey']
          attribute
        )

        Upload.upload(
          url: "/#{resourceName}",
          fields: {business_item: scope.businessItem, attributes: attributes, payment_terms: scope.businessItem.payment_terms},
          file: photos,
          fileFormDataName: _.map(photos, (photo, index) ->
            "file" + index
          )
        ).success(
          scope.saveSucceededCallback()
        ).error(
          (data, status, headers, config) ->
            scope.errors = data
            scope.errors.attributes = AttributesErrors.format_messages(data.attributes)
            TranslatedFlash.error("#{resourceName}.adding_failed")
        )

      scope.submit = (e) ->
        e.preventDefault()
        scope.loading = true
        scope.errors = {}
        scope.saveAndUploadPhotos()

        false
]
