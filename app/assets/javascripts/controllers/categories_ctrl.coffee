@Sim.controller 'CategoriesCtrl', ['CategoriesModal',
  (CategoriesModal) ->
    this.closeMe = CategoriesModal.deactivate
]
