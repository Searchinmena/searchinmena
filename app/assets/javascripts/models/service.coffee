@Sim.factory 'Service', ['$resource',
  ($resource) ->
    $resource('/services/:id', { id: '@id' })
]
