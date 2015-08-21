@Sim.factory 'Search', ['$resource',
  ($resource) ->
    Search = $resource('/search', {}, {
      query: { method:'GET', isArray: false }
    })

    angular.extend(Search.prototype,
      toParams: ->
        { type: @type, query: @query, page: @page }
    )

    Search
]

