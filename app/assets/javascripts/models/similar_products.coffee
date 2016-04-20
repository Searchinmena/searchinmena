@Sim.factory 'SimilarProducts', ['$resource','FETCH_SIMILAR_PRODUCTS',
  ($resource,FETCH_SIMILAR_PRODUCTS) ->
    $resource(FETCH_SIMILAR_PRODUCTS, { id: '@id' })
]
