class SIM.Attribute
  constructor: ->
    @name = ''
    @value = ''

  @fromParams: (params) ->
    attribute = new SIM.Attribute()
    attribute.id = params.id
    attribute.name = params.name
    attribute.value = params.value
    attribute

  isPresent: ->
    @name != '' || @value != ''
