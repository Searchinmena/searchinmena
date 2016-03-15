@Sim.service 'SearchService', ['Search',
  (Search) ->
    searchTypes: ->
      ['product', 'business', 'service']

    translationKeyFor: (type) ->
      "search.types.#{type}"

    perform: (searchParams, successCallback) ->
      Search.query(searchParams).$promise.then((data) ->
        successCallback(data)
      )
]

