@Sim.service "SmartFlash", ['Flash',
  (Flash) ->
    success: (message) ->
      Flash.create("success", message)

    info: (message) ->
      Flash.create("info", message)

    warning: (message) ->
      Flash.create("warning", message)

    error: (message) ->
      Flash.create("danger", message)
      Flash.pause()
]
