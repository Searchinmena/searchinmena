@Sim.service 'BusinessItemLoader', ['Business',  'SmartFlash', '$state',
  'Lightbox', 'MessageModal', 'BusinessItemPresenter',
  (Business, SmartFlash, $state, Lightbox, MessageModal, BusinessItemPresenter) ->
    initialize: (businessItemFactory, id, scope) ->
      scope.MessageModal = MessageModal

      businessItemFactory.get({ id: id },
        (attributes) ->
          scope.businessItem = businessItemFactory.buildPresenter(attributes)
          scope.business = Business.get({ id: scope.businessItem.businessId() })
          scope.business
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
