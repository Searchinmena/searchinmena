@Sim.service "language", ['$cookies', '$translate', '$rootScope',
  ($cookies, $translate, $rootScope) ->
    set: (langKey) ->
      $cookies.put("locale", langKey, { path: "/" })
      $translate.use(langKey)

    get: ->
      $cookies.get("locale")
]
