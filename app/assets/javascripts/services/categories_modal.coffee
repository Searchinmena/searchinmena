@Sim.factory 'CategoriesModal', ['btfModal', (btfModal) ->
  btfModal(
    controller: 'CategoriesCtrl',
    controllerAs: 'modal',
    templateUrl: '/assets/templates/categories'
  )
]
