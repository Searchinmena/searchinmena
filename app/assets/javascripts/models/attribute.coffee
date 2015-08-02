class SIM.Attribute
  constructor: ->
    @name = ''
    @value = ''

  isPresent: ->
    @name != '' || @value != ''
