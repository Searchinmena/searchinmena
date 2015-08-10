@Sim.controller 'CompanyCtrl', ['$scope', '$http', 'USER_BUSINESS_PATH', 'COMPANY_SHOW_PATH'
  ($scope, $http, USER_BUSINESS_PATH, COMPANY_SHOW_PATH) ->
    tabs = [ 'basic_info', 'trade_details', 'certifications' ]

    $scope.tabs = for tab in tabs
      new SIM.Tab("company.#{tab}", "company.tabs.#{tab}")

    businessId = undefined

    $http.get(USER_BUSINESS_PATH).success((businessAttributes) ->
      businessId = businessAttributes.id
    )

    $scope.companyShowPath = ->
      COMPANY_SHOW_PATH + businessId
]
