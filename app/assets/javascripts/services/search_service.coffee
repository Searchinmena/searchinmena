@Sim.service 'SearchService', ['Search',
  (Search) ->
    searchTypes: ->
      ['all', 'product', 'service', 'business']

    translationKeyFor: (type) ->
      "search.types.#{type}"

    perform: (searchParams, successCallback) ->
      Search.query(searchParams).$promise.then((data) ->
        successCallback(data)
      )
]

