describe SIM.Breadcrumbs, ->
  beforeEach ->
    @defaultTitle = "Choose Item"
    @breadcrumbs = new SIM.Breadcrumbs(@defaultTitle)

  class Item
    constructor: (id, level) ->
      @id = id
      @level = level

  describe "push", ->
    beforeEach ->
      @item = new Item(1, 1)
      @breadcrumbs.push(@item)

    it "nulls title", ->
      expect(@breadcrumbs.title).toBe(null)

    describe "items are empty", ->
      it "pushes item to items", ->
        expect(@breadcrumbs.items).toEqual([@item])

    describe "item with the same level is already chosen", ->
      it "doesn't duplicate item", ->
        @item.level = 7
        item = new Item(2, 7)
        @breadcrumbs.push(item)
        
        expect(@breadcrumbs.items).toEqual([@item])

  describe "pop", ->
    beforeEach ->
      @item = new Item(1, 1)
      @breadcrumbs.push(@item)

    it "removes item from items", ->
      @breadcrumbs.push(new Item(2, 2))
      @breadcrumbs.pop()

      expect(@breadcrumbs.items).toEqual([@item])

    it "sets default title", ->
      expect(@breadcrumbs.title).toEqual(null)

    describe "removing last item", ->
      beforeEach ->
        @breadcrumbs.pop()

      it "removes item from items", ->
        expect(@breadcrumbs.items).toEqual([])

      it "sets default title", ->
        expect(@breadcrumbs.title).toEqual(@defaultTitle)

  describe "current", ->
    it "returns last item", ->
      @breadcrumbs.push(new Item(1, 1))
      current = new Item(2, 2)
      @breadcrumbs.push(current)
      expect(@breadcrumbs.current()).toEqual(current)

    describe "items are empty", ->
      it "returns undefined", ->
        expect(@breadcrumbs.current()).toBe(undefined)


