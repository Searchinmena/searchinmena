@Sim.factory 'Product', ['$resource',
  ($resource) ->
    $resource('/products/:id', { id: '@id' })
]

