@Sim.service 'BusinessIsPremium', ['$http', 'USER_BUSINESS_PATH',
  ($http, USER_BUSINESS_PATH) ->

    isPremium: (scope)->
      $http.get(USER_BUSINESS_PATH).success((businessAttributes) ->
        scope.premium = businessAttributes.feature
      )
]
