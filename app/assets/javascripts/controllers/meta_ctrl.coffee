@Sim.controller 'MetaCtrl', ['MetaService', '$rootScope', '$document', 'ProductFactory', 'ServiceFactory',
  (MetaService, $rootScope, $document, ProductFactory, ServiceFactory) ->

    postMeta = (title, description, keywords) ->
      $rootScope.metaservice = MetaService
      $rootScope.metaservice.set title, description, keywords

    businessMeta: (item) ->
      postMeta item.business.name, item.business.introduction, item.business.name

    productMeta: (id) ->
      ProductFactory.get({ id: id },
        (attributes) ->
          businessItem = ProductFactory.buildPresenter(attributes)
          postMeta businessItem.attributes.name, businessItem.attributes.description,
            businessItem.attributes.name
      )

    serviceMeta: (id) ->
      ServiceFactory.get({ id: id },
        (attributes) ->
          businessItem = ServiceFactory.buildPresenter(attributes)
          postMeta businessItem.attributes.name, businessItem.attributes.description,
            businessItem.attributes.name
      )
]
