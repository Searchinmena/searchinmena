@Sim.service 'ResultPresenterFactory', ['ProductPresenter', 'ServicePresenter',
  'BusinessPresenter',
  (ProductPresenter, ServicePresenter, BusinessPresenter) ->
    REPOSITORY = {
      product: ProductPresenter,
      service: ServicePresenter,
      business: BusinessPresenter
    }

    build: (type, resultData) ->
      klass = REPOSITORY[type]
      new klass(resultData)
]

