@Sim.factory 'Search', ['$resource',
  ($resource) ->
    Search = $resource('/search', {}, {
      query: { method:'GET', isArray: false }
    })

    angular.extend(Search.prototype,
      toParams: ->
        { type: @type, query: @query, business_type: @business_type, country: @country, category: @category, page: @page, viewOption: @viewOption }

      toFilterParams: (pageParam = '1') ->
        { type: @type, query: @query, business_type: @business_type, country: @country, category: @category, page: pageParam, viewOption: @viewOption }
    )

    Search
]

