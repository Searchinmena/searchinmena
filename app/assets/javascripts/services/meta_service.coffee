@Sim.service 'MetaService', [
  () ->
    {
      set: (title, description, keywords) ->
        metaTitle = this.titleRule(title)
        metaKeywords = keywords
        if description == null
          metaDescription = this.descriptionRule(title)
        else
          metaDescription = this.descriptionRule(description)

        $('html title').html(metaTitle)
        $('html meta[name=description]').attr('content', metaDescription)
        $('html meta[name=keywords]').attr('content', metaKeywords)

      titleRule: (title) ->
        title.substring(0, 54);

      descriptionRule: (description) ->
        description.substring(0, 159);

    }
]
