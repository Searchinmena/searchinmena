class BusinessItemsPage
  constructor: ->
    @deleteLinkCss = "a.delete"
    @itemCss = ".item-summary"
    @showLinkCss = "a.see-page"

    @confirmationModalCss = ".confirmation-modal"
    @confimationOkCss = ".confirmation-modal .ok"
    @confimationCancelCss = ".confirmation-modal .cancel"

  clickDelete: ->
    element.all(By.css(@deleteLinkCss)).get(0).click()

  deleteBusinessItem: ->
    @clickDelete()
    @confirmDeletion()

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
    @clickDelete()
    expect(@confirmationModal().isPresent()).toBe(true)
    expect(@itemsCount()).toEqual(1)

    @cancelDeletion()
    expect(@itemsCount()).toEqual(1)
    
    @clickDelete()
    @confirmDeletion()
    expect(@itemsCount()).toEqual(0)

  checkShowingSingleBusinessItem: ->
    link = @showLink()
    href = link.getAttribute("href")
    @showLink().click()

    expect(browser.getCurrentUrl()).toEqual(href)

    @get()
    @deleteBusinessItem()

module.exports = BusinessItemsPage
