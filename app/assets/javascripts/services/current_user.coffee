@Sim.service 'CurrentUser', ['User', 'SIGN_IN_PATH',
  (User, SIGN_IN_PATH) ->
    authorize: (scope) ->
      User.get(
        (data) ->
          scope.user = new User(data)
        ,
        (error) ->
          window.location = SIGN_IN_PATH
      )
]
