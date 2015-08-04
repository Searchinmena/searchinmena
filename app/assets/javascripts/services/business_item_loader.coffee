@Sim.service 'BusinessItemLoader', ['Business',  'SmartFlash', '$state', 'Lightbox',
  (Business, SmartFlash, $state, Lightbox) ->
    initialize: (businessItemFactory, id, scope) ->
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
