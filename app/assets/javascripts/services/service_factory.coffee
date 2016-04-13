@Sim.factory 'ServiceFactory', ['Service', 'ServicePresenter','SimilarServices',
  (Service, ServicePresenter,SimilarServices) ->
    resourceName: ->
      'services'

    build: (attributes) ->
      new Service(attributes)

    buildPresenter: (attributes) ->
      new ServicePresenter(attributes)

    get: (params, successCallback, errorCallback) ->
      Service.get(params, successCallback, errorCallback)

    get_similar: (params, successCallback, errorCallback) ->
      SimilarServices.get(params, successCallback, errorCallback)

    delete: (params, successCallback, errorCallback) ->
      Service.delete(params, successCallback, errorCallback)

    indexPath: ->
      "dashboard.services"
]

