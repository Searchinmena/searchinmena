@Sim.service 'BusinessItemLoader', ['Business',  'SmartFlash', '$state',
  'Lightbox', 'MessageModal',
  (Business, SmartFlash, $state, Lightbox, MessageModal) ->
    initialize: (businessItemFactory, id, scope) ->
      scope.MessageModal = MessageModal

      businessItemFactory.get({ id: id },
        (attributes) ->
          scope.businessItem = new SIM.BusinessItem(attributes)
          scope.business = Business.get({ id: attributes['business_id'] })
          scope.photos = scope.businessItem.get('photos')
          scope.coverPhoto = scope.businessItem.get('cover_photo')
        ,
        ->
          $state.go("root")
      )

      scope.openPhotoModal = (photos, index) ->
        Lightbox.openModal(photos, index, { animation: false })

      scope.openCoverPhoto = ->
        scope.openPhotoModal([scope.coverPhoto], 0)

      scope.openLightboxModal = (index) ->
        scope.openPhotoModal(scope.photos, index)
]
