@Sim.factory 'Search', ['$resource',
  ($resource) ->
    Search = $resource('/search')

    angular.extend(Search.prototype,
      toParams: ->
        { type: @type, query: @query }
    )

    Search
]

