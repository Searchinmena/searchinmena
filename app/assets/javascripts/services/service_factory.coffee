@Sim.factory 'ServiceFactory', ['Service', 'ServicePresenter',
  (Service, ServicePresenter) ->
    resourceName: ->
      'services'

    build: (attributes) ->
      new Service(attributes)

    buildPresenter: (attributes) ->
      new ServicePresenter(attributes)

    get: (params, successCallback, errorCallback) ->
      Service.get(params, successCallback, errorCallback)

    delete: (params, successCallback, errorCallback) ->
      Service.delete(params, successCallback, errorCallback)

    indexPath: ->
      "dashboard.services"
]

