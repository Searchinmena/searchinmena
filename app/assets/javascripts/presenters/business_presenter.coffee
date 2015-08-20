class SIM.BusinessPresenter
  constructor: (business, tags, types) ->
    @business = business
    @tags = tags
    @types = types

  id: -> @business.id

  name: -> @business.name

  phone: -> @business.phone

  addressLine1: ->
    @business.address_line_1

  addressLine2: ->
    @business.address_line_2

  yearRegistered: -> @business.year_registered

  noOfEmployees: -> @business.no_of_employees

  introduction: -> @business.introduction

  location: ->
    if @business.city
      @business.city + ', ' + @business.country
    else
      @business.country

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

  path: ->
    "business({ id: #{@id()} })"

@Sim.value('BusinessPresenter', SIM.BusinessPresenter)
