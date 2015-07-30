@Sim.service 'CurrentUser', ['User', '$location',
  (User, $location) ->
    authorize: (scope) ->
      User.get(
        (data) ->
          scope.user = new User(data)
        ,
        (error) ->
          $location.path(window.Sim.SIGN_IN_PATH)
      )
]
