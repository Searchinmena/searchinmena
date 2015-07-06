@Sim.service "TranslatedFlash", ['SmartFlash', '$translate',
  (SmartFlash, $translate) ->
    success: (key) ->
      $translate(key).then((translation) ->
        SmartFlash.success(translation)
      )

    info: (key) ->
      $translate(key).then((translation) ->
        SmartFlash.info(translation)
      )

    warning: (key) ->
      $translate(key).then((translation) ->
        SmartFlash.warning(translation)
      )

    error: (key) ->
      $translate(key).then((translation) ->
        SmartFlash.error(translation)
      )
]
