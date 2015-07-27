@Sim.service 'CurrentUser', ['User',
  (User) ->
    authorize: (scope) ->
      User.get(
        (data) ->
          scope.user = new User(data)
        ,
        (error) ->
          window.location = window.Sim.SIGN_IN_PATH
      )
]
