module.exports =
  switchLanguage: (language) ->
    button = element(By.cssContainingText("a.language-choice", language))
    button.click()

  dirAttribute: ->
    body = element(By.css("body"))
    body.getAttribute("dir")

  signInHeader: ->
    element(By.css(".form-header h1.form-title"))

  activeLink: ->
    element(By.css("a.nav-link.active"))

  goToOtherDashboardPart: ->
    productsLink = element(By.css("a[href='#/products']"))
    productsLink.click()

