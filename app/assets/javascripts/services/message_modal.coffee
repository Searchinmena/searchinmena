@Sim.service 'MessageModal', ['$modal', 'CurrentUser',
  ($modal, CurrentUser) ->
    new: (businessId) ->
      CurrentUser.authorize(=>
        @open(businessId)
      )
      
    open: (businessId) =>
      modalInstance = $modal.open(
        templateUrl: 'components/new_message.html',
        controller: 'MessagesNewCtrl',
        resolve: {
          businessId: ->
            businessId
        }
        animation: false,
        size: 'lg'
      )
]

