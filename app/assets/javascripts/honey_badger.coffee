# if @honeybadgerEnv == 'demo' || @honeybadgerEnv == 'production'
#  Honeybadger.configure({
#    api_key: '7954f83f',
#    environment: window.honeybadgerEnv,
#  });
#
#  @Sim.factory '$exceptionHandler', ->
#    (exception, cause) ->
#      Honeybadger.notify(exception)
