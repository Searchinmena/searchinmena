@Sim.factory 'User', ['$resource',
  ($resource) ->
    User = $resource('/user')

    angular.extend(User.prototype,
      fullName: ->
        "#{@first_name} #{@last_name}"

      canSeeBusinessItems: ->
        @can_see_business_items

      emailConfirmed: ->
        !!@confirmed_at
    )
    
    User
]

