@Sim.controller 'MetaCtrl', ['MetaService', '$rootScope', '$document', 'ProductFactory', 'ServiceFactory',
  (MetaService, $rootScope, $document, ProductFactory, ServiceFactory) ->

    postMeta = (title, description, keywords) ->
      $rootScope.metaservice = MetaService
      $rootScope.metaservice.set title, description, keywords

    homeMeta: () ->
      pageTitle = 'Manufacturer, Trader, Supplier, Distributor in MENA'
      pageDescription = 'Largest B2B marketplace for Manufacturers, Traders, Suppliers, Distributors, & Wholesalers ' +
          'in Saudi, UAE, Turkey, & others Middle East & North Africa countries'
      pageKeywords = 'B2B marketplace, directory, Manufacturers, Traders, Suppliers, Distributors, Wholesalers, ' +
          'Saudi Arabia, UAE, Turkey, Morocco, Turkey, Qatar, Middle East, North Africa, Salim Akil'

      postMeta pageTitle, pageDescription, pageKeywords

    resultPage: (type) ->

      if type == 'product'
        itemTitle = 'Find trusted supplier to source products & samples'
        itemDescription = 'Find the trusted supplier and source products and samples from Saudi Arabia, UAE, Turkey, Egypt, Morocco and other Middle East & North Africa countries'
        itemKeywords = 'Trusted, supplier, source, products, order, samples, Saudi Arabia, UAE, Turkey, Egypt, Morocco, Middle East, North Africa'
      else if type == 'service'
        itemTitle = 'Connect with businesses & buy high quality of services'
        itemDescription = 'Connect with the best business providers & buy high quality of services in Saudi Arabia, UAE, Turkey, Egypt, Morocco & other Middle East & North Africa countries'
        itemKeywords = 'Business providers, buy, order, services, Saudi Arabia, UAE, Turkey, Egypt, Morocco, Middle East, North Africa'
      else
        itemTitle = 'Create business opportunities with SMEs'
        itemDescription = 'Create a business opportunity with Small & Medium Enterprise such as Distributors, & Traders to grow in Saudi, UAE & other Middle East & North Africa countries'
        itemKeywords = 'Business, opportunity, SME, Small, Medium, Enterprises, companies, Distributors, Traders, grow, expand, Saudi, UAE, Qatar, GCC, Turkey, Egypt, Morocco, Middle East, North Africa'


      postMeta itemTitle, itemDescription, itemKeywords

    businessMeta: (item) ->
      businessTags = this.getTags(item.tags)
      businessTyps = this.getBusinessType(item.types)
      businessTitle = item.business.name  + ' in ' + item.business.country + ' | ' + businessTags
      businessDescription = businessTyps + ' for ' + businessTags + ' in ' + item.business.country

      businessKeywords = businessDescription
      postMeta businessTitle, businessDescription, businessKeywords

    productMeta: (id) ->
      # get function, so it will available inside ProductFactory
      getCategory =  this.getCategories
      ProductFactory.get({ id: id },
        (attributes) ->
          businessItem = ProductFactory.buildPresenter(attributes)
          businessItemName = businessItem.attributes.name
          businessItemCountry = businessItem.attributes.business.country
          businessItemCategories = getCategory(businessItem.attributes.breadcrumbs)

          businessItemtitle = businessItemName + ' in ' + businessItemCountry + ' | ' + businessItemCategories

          postMeta businessItemtitle, businessItem.attributes.description,
            businessItemtitle
      )

    serviceMeta: (id) ->
      # get function, so it will available inside ProductFactory
      getCategory =  this.getCategories
      ServiceFactory.get({ id: id },
        (attributes) ->
          businessItem = ServiceFactory.buildPresenter(attributes)
          businessItemName = businessItem.attributes.name
          businessItemCountry = businessItem.attributes.business.country
          businessItemCategories = getCategory(businessItem.attributes.breadcrumbs)

          businessItemtitle = businessItemName + ' in ' + businessItemCountry + ' | ' + businessItemCategories

          postMeta businessItemtitle, businessItem.attributes.description,
            businessItemtitle
      )

    mergeTitle: (value) ->
      # define default value to avoid undefine return
      returnValue = ''
      if value
        returnValue = ' | ' + value
      return returnValue

    getCategories: (categories) ->
      categoriesValue = ''
      for key,value of categories
        categoriesValue += value.name + ', '
      return categoriesValue

    getTags: (tags) ->
      tagsValue = ''
      for key,value of tags
        tagsValue += value.label
      return tagsValue

    getBusinessType: (type) ->
      businessTypes = ''
      for key,value of type
        businessTypes = value.label
      return businessTypes
]
