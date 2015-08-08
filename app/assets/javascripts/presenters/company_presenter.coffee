class CompanyPresenter
  constructor: (company, tags, types) ->
    @company = company
    @tags = tags
    @types = types

  name: -> @company.name

  phone: -> @company.phone

  yearRegistered: -> @company.year_registered

  noOfEmployees: -> @company.no_of_employees

  introduction: -> @company.introduction

  location: ->
    if @company.city
      @company.city + ', ' + @company.country
    else
      @company.country

  mainProducts: ->
    if @tags
      @tags.map( (tag) -> tag.label ).join(', ')
    else
      undefined

  businessTypes: -> 
    if @types
      @types.map( (type) -> type.label ).join(' | ')
    else
      undefined

@Sim.value('CompanyPresenter', CompanyPresenter)
