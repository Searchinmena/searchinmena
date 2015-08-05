@Sim.service 'CurrentUser', ['User', 'SIGN_IN_PATH',
  (User, SIGN_IN_PATH) ->
    authorize: () ->
      User.get(
        (data) =>
          @user = new User(data)
        ,
        (error) ->
          window.location = SIGN_IN_PATH
      )

    isPresent: ->
      @user

    canSeeBusinessItems: ->
      @user && @user.canSeeBusinessItems()
]
