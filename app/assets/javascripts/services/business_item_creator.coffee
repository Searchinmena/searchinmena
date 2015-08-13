@Sim.service 'BusinessItemCreator', ['$rootScope', '$http', '$state'
  '$modal', 'TranslatedFlash', 'BusinessItemWithDependencies', 'Upload', 'AttributesErrors', 'MIN_IMAGE_WIDTH', 'MIN_IMAGE_HEIGHT',
  ($rootScope, $http, $state, $modal, TranslatedFlash,
    BusinessItemWithDependencies, Upload, AttributesErrors,
    MIN_IMAGE_WIDTH, MIN_IMAGE_HEIGHT) ->

    initialize: (scope, selectsLoader, resourceName, photos_path, categoriesController, businessItemFactory) ->
      scope.businessItem = businessItemFactory.build()
      scope.errors = {}
      scope.attributes = (new SIM.Attribute() for i in [0..1])

      scope.photoCommentTranslationData = {
        min_image_width: MIN_IMAGE_WIDTH,
        min_image_height: MIN_IMAGE_HEIGHT
      }

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

      scope.saveAndUploadPhotos = ->
        photos = scope.businessItem.photos

        attributes = _(scope.attributes).filter((attribute) ->
          attribute.isPresent()
        ).map((attribute) ->
          delete attribute['$$hashKey']
          attribute
        )

        BusinessItemWithDependencies.create(
          resourceName, scope.businessItem, attributes, scope.businessItem.payment_terms, photos
        ).then(->
          TranslatedFlash.success("#{resourceName}.successfully_added")
          $state.go("dashboard.#{resourceName}")
        ,
        (data) ->
          scope.errors = data
          if data['business_item']
            scope.errors.photos_general = data['business_item']['photos_count']
          scope.errors.attributes = AttributesErrors.format_messages(data.attributes)
          TranslatedFlash.error("#{resourceName}.adding_failed")
          scope.loading = false
        )

      scope.submit = (e) ->
        e.preventDefault()
        scope.loading = true
        scope.errors = {}
        scope.saveAndUploadPhotos()

        false
]
