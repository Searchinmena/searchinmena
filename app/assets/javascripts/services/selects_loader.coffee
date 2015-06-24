@Sim.service "selectsLoader", ['$http', 'language',
  ($http, language) ->
    loadSelectsData: (scope, config) ->
      for key, path of config
        @_loadDataForSelect(key, path, scope)

    _loadDataForSelect: (key, path, scope) ->
      $http.get(path, { params: { locale: language.get() } })
        .success((data) ->
          scope[key] = data
        )
]
