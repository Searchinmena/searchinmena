module.exports =
  loginInFacebook: ->
    browser.driver.findElement(By.id("email")).sendKeys("dgovgxl_chengstein_1433862215@tfbnw.net")
    browser.driver.findElement(By.id("pass")).sendKeys("Chengstein55")
    browser.driver.findElement(By.name("login")).click()

  fieldValue: (field_id) ->
    element(By.id(field_id)).getAttribute("value")

  fbLinkElement: ->
    element(By.css(".facebook-sign-up"))

  fbNoticeElement: ->
    element(By.css(".fb-notice"))
