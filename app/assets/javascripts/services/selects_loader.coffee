@Sim.service "SelectsLoader", ['$http', 'language',
  ($http, language) ->
    UNITS_PATH = "/api/units"
    CURRENCIES_PATH = "/api/currencies"
    FREQUENCIES_PATH = "/api/frequencies"
    PAYMENT_TERMS_PATH = "/api/payment_terms"

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
