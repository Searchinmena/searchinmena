@Sim.service 'ResultPresenterFactory', ['ProductPresenter', 'ServicePresenter',
  'BusinessPresenter',
  (ProductPresenter, ServicePresenter, BusinessPresenter) ->
    REPOSITORY = {
      product: ProductPresenter,
      service: ServicePresenter,
      business: BusinessPresenter
    }

    build: (resultData) ->
      klass = REPOSITORY[resultData.key]
      new klass(resultData)
]

