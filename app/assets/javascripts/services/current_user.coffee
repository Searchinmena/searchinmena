@Sim.service 'CurrentUser', ['$state', 'User',
  ($state, User) ->
    authorize: (scope) ->
      User.get(
        (data) ->
          scope.user = new User(data)
        ,
        (error) ->
          $state.go("root")
      )
]
