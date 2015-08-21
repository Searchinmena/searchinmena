@Sim.factory 'ServiceFactory', ['Service', 'ServicePresenter',
  (Service, ServicePresenter) ->
    build: ->
      new Service()

    buildPresenter: (attributes) ->
      new ServicePresenter(attributes)

    get: (params, successCallback, errorCallback) ->
      Service.get(params, successCallback, errorCallback)

    delete: (params, successCallback, errorCallback) ->
      Service.delete(params, successCallback, errorCallback)

    indexPath: ->
      "dashboard.services"
]

