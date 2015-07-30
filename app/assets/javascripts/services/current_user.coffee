@Sim.service 'CurrentUser', ['User', '$location', 'SIGN_IN_PATH',
  (User, $location, SIGN_IN_PATH) ->
    authorize: (scope) ->
      User.get(
        (data) ->
          scope.user = new User(data)
        ,
        (error) ->
          $location.path(SIGN_IN_PATH)
      )
]
