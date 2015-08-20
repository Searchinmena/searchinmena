@Sim.service 'ResultPresenterFactory', ['ProductPresenter', 'ServicePresenter',
  (ProductPresenter, ServicePresenter) ->
    REPOSITORY = {
      product: ProductPresenter,
      service: ServicePresenter
    }

    build: (type, resultData) ->
      klass = REPOSITORY[type]
      new klass(resultData)
]

