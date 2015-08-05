@Sim.service "AttributesErrors", [
  () ->
    format_messages: (errors) ->
      _.map(errors, (attribute_errors) ->
        for field, message of attribute_errors
          "Attribute " + field + " " + message
      )

]
