@Sim.factory 'Service', ['$resource',
  ($resource) ->
    Service = $resource('/services/:id', { id: '@id' }, {
      get: { method:'GET', isArray: false },
      get_prev: {method:'GET', isArray: false, url: '/services/:id/prev_item'}
      get_next: {method:'GET', isArray: false, url: '/services/:id/next_item'}
    })
]
