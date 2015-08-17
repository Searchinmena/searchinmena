@Sim.controller 'BusinessBasicInfoCtrl', ['$scope', '$http', '$translate',
  'selectsLoader', 'TranslatedFlash', 'TAGS_PATH', 'USER_BUSINESS_PATH',
  'language', 'CurrentUser', 'Upload', '$q', 'MIN_IMAGE_WIDTH',
  'MIN_IMAGE_HEIGHT', 'MAX_FILE_SIZE_IN_MB',
  ($scope, $http, $translate, selectsLoader, TranslatedFlash, TAGS_PATH,
    USER_BUSINESS_PATH, language, CurrentUser, Upload, $q, MIN_IMAGE_WIDTH,
    MIN_IMAGE_HEIGHT, MAX_FILE_SIZE_IN_MB) ->

    config = {
      countries: '/countries',
      business_types: '/business_types'
    }

    tags_params = (business_id) -> {
      params: {
        business_id: business_id,
        locale: language.get()
      }
    }

    selectsLoader.loadSelectsData($scope, config)

    $http.get(USER_BUSINESS_PATH).success((businessAttributes) ->
      $scope.form.business = businessAttributes

      $http.get('business_tags', tags_params(businessAttributes.id)).success((tags) ->
        $scope.form.tags = tags
      )
    )

    $scope.photoCommentTranslationData = {
      min_image_width: MIN_IMAGE_WIDTH,
      min_image_height: MIN_IMAGE_HEIGHT,
      max_file_size_in_mb: MAX_FILE_SIZE_IN_MB
    }

    namesForImages = (images) ->
      names = _.map(images, (image, index) ->
        'file' + index
      )

      logoIndex = images.indexOf($scope.form.business.logo[0])
      if logoIndex != -1
        names[logoIndex] = 'logo'
      names

    $scope.saveAndUploadPhotos = ->
      $scope.loading = true

      logo = $scope.form.business.logo
      photos = $scope.form.business.photos
      allImages = if logo then _.compact(logo.concat(photos)) else photos

      Upload.upload(
        url: USER_BUSINESS_PATH,
        method: 'PUT',
        fields: { business: $scope.form.business },
        file: allImages,
        fileFormDataName: namesForImages(allImages)
      ).then(->
        # reauthorize user to show correct menu
        CurrentUser.authorize()
        $scope.errors = {}
        TranslatedFlash.success('business.successfully_saved')
        $scope.loading = false
      ,
      (data) ->
        $scope.errors = data['data']
        # if data['business']
        #   $scope.errors.photos_general = data['data']['business']['photos_count']
        TranslatedFlash.error('business.saving_failed')
        $scope.loading = false
      )

    $scope.removeLogo = ->
      $scope.form.business.logo = null

    $scope.removePhoto = (photo) ->
      index = $scope.form.business.photos.indexOf(photo)
      $scope.form.business.photos.splice(index, 1)

    $scope.loadTags = (query) ->
      $http.get(TAGS_PATH, params: { query: query })

    $scope.submit = (e) ->
      e.preventDefault()
      $scope.saveAndUploadPhotos()

      # $http(
      #   url: USER_BUSINESS_PATH,
      #   data: $scope.form,
      #   method: 'PUT'
      # ).success(->
      #   # reauthorize user to show correct menu
      #   CurrentUser.authorize()

      #   $scope.errors = {}
      #   TranslatedFlash.success('business.successfully_saved')
      # ).error((errors) ->
      #   $scope.errors = errors
      #   TranslatedFlash.error('business.saving_failed')
      # )

      false
]
