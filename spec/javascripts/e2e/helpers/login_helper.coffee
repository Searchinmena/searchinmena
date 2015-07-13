module.exports =
  login: ->
    browser.get("/users/sign_in")

    emailField = element(By.id("user_email"))
    passwordField = element(By.id("user_password"))
    emailField.sendKeys("test@example.org")
    passwordField.sendKeys("testtest")

    submitButton = element(By.css("input[type=submit]"))
    submitButton.click()

  logout: ->
    logoutLink = element(By.css("a[href='/users/sign_out']"))
    logoutLink.click()
