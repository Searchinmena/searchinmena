class BusinessItemsPage
  constructor: ->
    @deleteLinkCss = "a.delete"
    @itemCss = ".item-summary"

    @showLinkCss = "a.see-page"

  deleteBusinessItem: ->
    element.all(By.css(@deleteLinkCss)).get(0).click()

  itemsCount: ->
    element.all(By.css(@itemCss)).count()

  showLink: ->
    element.all(By.css(@showLinkCss)).get(0)

module.exports = BusinessItemsPage
