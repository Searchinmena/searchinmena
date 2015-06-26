class SIM.Category
  constructor: (attributes) ->
    @id = attributes.id
    @name = attributes.name
    @parentId = attributes.parent_id
    @selected = false
