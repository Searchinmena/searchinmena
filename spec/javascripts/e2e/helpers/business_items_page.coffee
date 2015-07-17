class BusinessItemsPage
  constructor: ->
    @deleteLinkCss = "a.delete"
    @itemCss = ".item-summary"

    @showLinkCss = "a.see-page"

    @confirmationModalCss = ".confirmation-modal"
    @confimationOkCss = ".confirmation-modal .ok"
    @confimationCancelCss = ".confirmation-modal .cancel"

  deleteBusinessItem: ->
    element.all(By.css(@deleteLinkCss)).get(0).click()

  itemsCount: ->
    element.all(By.css(@itemCss)).count()

  showLink: ->
    element.all(By.css(@showLinkCss)).get(0)

  confirmationModal: ->
    element(By.css(@confirmationModalCss))

  confirmDeletion: ->
    element(By.css(@confimationOkCss)).click()

  cancelDeletion: ->
    element(By.css(@confimationCancelCss)).click()

  checkRemovingBusinessItem: ->
    @deleteBusinessItem()
    expect(@confirmationModal().isPresent()).toBe(true)
    expect(@itemsCount()).toEqual(1)

    @cancelDeletion()
    expect(@itemsCount()).toEqual(1)
    
    @deleteBusinessItem()
    @confirmDeletion()
    expect(@itemsCount()).toEqual(0)

  checkShowingSingleBusinessItem: ->
    link = @showLink()
    href = link.getAttribute("href")
    @showLink().click()

    expect(browser.getCurrentUrl()).toEqual(href)

module.exports = BusinessItemsPage
