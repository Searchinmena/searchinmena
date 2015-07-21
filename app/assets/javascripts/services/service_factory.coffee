@Sim.factory 'ServiceFactory', ['Service', (Service) ->
  build: ->
    new Service()

  get: (params, successCallback, errorCallback) ->
    Service.get(params, successCallback, errorCallback)

  delete: (params, successCallback, errorCallback) ->
    Service.delete(params, successCallback, errorCallback)
]

