@Sim.controller 'BusinessShowCtrl', ['$scope', '$http', '$stateParams',
  'BusinessPresenter', 'language', 'BUSINESSES_PATH', 'BUSINESS_TYPES_PATH',
  'BUSINESS_TAGS_PATH', 'MessageModal', 'BusinessSpecificProducts', 'BusinessSpecificServices',
  'ShowPhoneNumber', 'MetaService',
  ($scope, $http, $stateParams, BusinessPresenter, language, BUSINESSES_PATH, BUSINESS_TYPES_PATH,
   BUSINESS_TAGS_PATH, MessageModal, BusinessSpecificProducts, BusinessSpecificServices, ShowPhoneNumber, MetaService) ->
    params = {
      params: {
        business_id: $stateParams.id,
        locale: language.get()
      }
    }

    $http.get(BUSINESSES_PATH + $stateParams.id).success((businessAttributes) ->
      $http.get(BUSINESS_TAGS_PATH, params).success((tags) ->
        $http.get(BUSINESS_TYPES_PATH, params).success((types) ->
          $scope.businessPresenter = new BusinessPresenter(businessAttributes, tags, types)
          # set meta tags
          $scope.businessMeta($scope.businessPresenter)
          if $scope.businessPresenter.phone()
            ShowPhoneNumber.initialize(false, $scope)
        )
      )
    )

    BusinessSpecificProducts.initialize(
      $stateParams.id, $scope)

    BusinessSpecificServices.initialize(
      $stateParams.id, $scope)

    $scope.MessageModal = MessageModal

    $scope.showPhone = () ->
      $scope.showPhoneNumber = true

    $scope.businessMeta = (item) ->
      businessTags = $scope.getTags(item.tags)
      businessTyps = $scope.getBusinessType(item.types)
      businessTitle = item.business.name  + ' in ' + item.business.country + ' | ' + businessTags
      businessDescription = businessTyps + ' for ' + businessTags + ' in ' + item.business.country
      businessKeywords = businessDescription

      MetaService.set businessTitle, businessDescription, businessKeywords

    $scope.getTags = (tags) ->
      tagsValue = ''
      for key,value of tags
        tagsValue += value.label + ', '
      return tagsValue

    $scope.getBusinessType = (type) ->
      businessTypes = ''
      for key,value of type
        businessTypes = value.label
      return businessTypes
]
