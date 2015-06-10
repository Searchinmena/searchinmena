helper = require('./helpers/facebook_helper.coffee')

describe "Facebook", ->
  describe "Facebook Registration", ->
    beforeEach ->
      browser.get("/users/sign_up")
      element(By.css(".facebook-sign-up")).click()

    it "hides facebook link and shows notice", ->
      helper.loginInFacebook()
      expect(element(By.css(".facebook-sign-up")).isDisplayed()).toBe(false)
      expect(element(By.css(".fb-notice")).isDisplayed()).toBe(true)

    it "prefills name and email fields with facebook data", ->
      expect(helper.fieldValue("user_first_name")).toEqual("Tom")
      expect(helper.fieldValue("user_last_name")).toEqual("Chengstein")
      expect(helper.fieldValue("user_email")).toEqual("dgovgxl_chengstein_1433862215@tfbnw.net")

  describe "Facebook Login", ->
    beforeEach ->
      browser.get("/users/sign_in")

    it "redirects to sign up page", ->
      element(By.css(".facebook-sign-up")).click()

      expect(browser.getCurrentUrl()).toMatch("/users/sign_up")
      expect(element(By.css(".fb-notice")).isDisplayed()).toBe(true)
