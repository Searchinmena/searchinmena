@Sim.service 'CurrentUser', ['User', 'SIGN_IN_PATH',
  (User, SIGN_IN_PATH) ->
    authorize: (callback) ->
      User.get(
        (data) =>
          @user = new User(data)
          callback() if callback
        ,
        (error) ->
          window.location = SIGN_IN_PATH
      )

    isPresent: ->
      @user

    canSeeBusinessItems: ->
      @user && @user.canSeeBusinessItems()

    emailConfirmed: ->
      @user && @user.emailConfirmed()

    fullName: ->
      @user && @user.fullName()

    businessId: ->
      @user && @user.businessId()
]
