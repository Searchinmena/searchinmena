@Sim.service 'SearchService', ['Search',
  (Search) ->
    perform: (searchParams, successCallback) ->
      Search.query(searchParams).$promise.then((data) ->
        successCallback(data)
      )
]

