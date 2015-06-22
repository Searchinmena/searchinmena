module.exports =
  switchLanguage: (language) ->
    button = element(By.cssContainingText("a.language-choice", language))
    button.click()

  dirAttribute: ->
    body = element(By.css("body"))
    body.getAttribute("dir")

  signInHeader: ->
    element(By.css(".form-header h1.form-title"))

  login: ->
    emailField = element(By.id("user_email"))
    passwordField = element(By.id("user_password"))
    emailField.sendKeys("test@example.org")
    passwordField.sendKeys("testtest")

    submitButton = element(By.css("input[type=submit]"))
    submitButton.click()

  activeLink: ->
    element(By.css("a.nav-link.active"))

  goToOtherDashboardPart: ->
    productsLink = element(By.css("a[href='#/products']"))
    productsLink.click()

  logout: ->
    logoutLink = element(By.css("a[href='/users/sign_out']"))
    logoutLink.click()
