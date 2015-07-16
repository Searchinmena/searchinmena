module.exports =
  login: (email) ->
    browser.get("/users/sign_in")

    emailField = element(By.id("user_email"))
    passwordField = element(By.id("user_password"))
    emailField.sendKeys(email)
    passwordField.sendKeys("testtest")

    submitButton = element(By.css("input[type=submit]"))
    submitButton.click()

  loginAsBuyer: ->
    @login("buyer@example.org")

  loginAsSeller: ->
    @login("seller@example.org")

  loginAsBoth: ->
    @login("both@example.org")

  logout: ->
    logoutLink = element(By.css("a[href='/users/sign_out']"))
    logoutLink.click()
