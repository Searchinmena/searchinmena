@Sim.service 'MetaService', [
  () ->
    {
      set: (title='', description='', keywords='') ->

        metaTitle = this.titleRule(title)
        metaDescription = this.descriptionRule(description)
        metaKeywords = this.keywordsRule(keywords)

        $('html title').html(metaTitle)
        $('html meta[name=description]').attr('content', metaDescription)
        $('html meta[name=keywords]').attr('content', metaKeywords)

      titleRule: (title) ->
        if title != ''
          title.substring(0, 54);
        else
          'Manufacturer, Trader, Supplier, Distributor in MENA'

      descriptionRule: (description) ->
        if description != ''
          description.substring(0, 159);
        else
          'Largest B2B marketplace for Manufacturers, Traders, Suppliers, Distributors, & Wholesalers ' +
            'in Saudi, UAE, Turkey, & others Middle East & North Africa countries'

      keywordsRule: (keywords) ->
        if keywords != ''
          keywords
        else
          'B2B marketplace, directory, Manufacturers, Traders, Suppliers, Distributors, Wholesalers, ' +
            'Saudi Arabia, UAE, Turkey, Morocco, Turkey, Qatar, Middle East, North Africa, Salim Akil'

      getCategories: (categories) ->
        categoriesValue = ''
        for key,value of categories
          categoriesValue += value.name + ', '
        return categoriesValue

    }
]
