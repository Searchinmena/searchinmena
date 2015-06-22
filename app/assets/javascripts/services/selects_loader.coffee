@Sim.service "SelectsLoader", ['$http', 'language',
  ($http, language) ->
    UNITS_PATH = "/units"
    CURRENCIES_PATH = "/currencies"
    FREQUENCIES_PATH = "/frequencies"
    PAYMENT_TERMS_PATH = "/payment_terms"

    CONFIG = {
      units: UNITS_PATH,
      currencies: CURRENCIES_PATH,
      frequencies: FREQUENCIES_PATH,
      payment_terms: PAYMENT_TERMS_PATH
    }

    loadSelectsData: (scope) ->
      for key, path of CONFIG
        @_loadDataForSelect(key, path, scope)

    _loadDataForSelect: (key, path, scope) ->
      $http.get(path, { params: { locale: language.get() } })
        .success((data) ->
          scope[key] = data
        )
]
