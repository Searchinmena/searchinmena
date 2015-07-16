class BusinessItemsPage
  constructor: ->
    @deleteLinkCss = "a.delete"
    @itemCss = ".item-summary"

  deleteBusinessItem: ->
    element.all(By.css(@deleteLinkCss)).get(0).click()

  itemsCount: ->
    element.all(By.css(@itemCss)).count()

module.exports = BusinessItemsPage
