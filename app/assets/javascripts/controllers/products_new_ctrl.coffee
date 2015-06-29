@Sim.controller 'ProductsNewCtrl', ['$scope', '$rootScope', '$http', '$state', '$modal',
  'TranslatedFlash', 'SelectsLoader', 'PhotosValidator', 'PhotosUploader',
  ($scope, $rootScope, $http, $state, $modal, TranslatedFlash, SelectsLoader,
    PhotosValidator, PhotosUploader) ->
    $scope.form = {}
    $scope.errors = {}
    $scope.form.attributes = [new SIM.Attribute()]

    $scope.showCategories = ->
      modalInstance = $modal.open(
        templateUrl: '/assets/templates/categories',
        controller: 'CategoriesCtrl',
        backdrop: true,
        animation: false,
        size: 'lg'
      )

      modalInstance.result.then($scope.setCategoryId)

    SelectsLoader.loadSelectsData($scope)

    $scope.setCategoryId = (category) ->
      $scope.form ||= {}
      $scope.form.product ||= {}
      $scope.form.product.category_id = category.id

    $scope.removePhoto = (photo) ->
      index = $scope.photos.indexOf(photo)
      $scope.photos.splice(index, 1)

    $scope.addAttribute = ->
      $scope.form.attributes.push(new SIM.Attribute())

    $scope.removeAttribute = (attribute) ->
      index = $scope.form.attributes.indexOf(attribute)
      $scope.form.attributes.splice(index, 1)

    $scope.submit = (e) ->
      e.preventDefault()
      $scope.errors = {}

      unless PhotosValidator.validate($scope)
        TranslatedFlash.error("products.adding_failed")
        return

      $http(
        url: e.target.action,
        data: $scope.form,
        method: 'POST'
      ).success((data) ->
        productId = data.id
        PhotosUploader.upload($scope.photos, productId,
          ->
            TranslatedFlash.success("products.successfully_added")
            $state.go("products")
          ,
          (errors) ->
            $scope.errors.photos = errors
            TranslatedFlash.error("products.adding_failed")
        )
      ).error((errors) ->
        $scope.errors = errors
        TranslatedFlash.error("products.adding_failed")
      )

      false
]
