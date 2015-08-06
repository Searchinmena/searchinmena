loginHelper = require("./helpers/login_helper.coffee")
helpers = require("./helpers/helpers.coffee")
DashboardPage = require("./helpers/dashboard_page.coffee")

describe DashboardPage, ->
  page = null

  beforeEach ->
    page = new DashboardPage()

  describe "user is logged in", ->
    afterEach ->
      loginHelper.logout()

    describe "when buyer user", ->
      it "hides products and services nav links", ->
        loginHelper.loginAsBuyer()
        page.get()
        expect(page.productsNavLink().isDisplayed()).toBe(false)
        expect(page.servicesNavLink().isDisplayed()).toBe(false)

      it "shows information with links instead of business item sections", ->
        loginHelper.loginAsBuyer()
        page.get()

        expect(page.buyerContent().isDisplayed()).toBe(true)

        # expect(page.browseLink().isDisplayed()).toBe(true)
        expect(page.createCompanyLink().isDisplayed()).toBe(true)

        expect(page.productsLink().isDisplayed()).toBe(false)
        expect(page.servicesLink().isDisplayed()).toBe(false)

    describe "when seller user", ->
      it "shows products and services nav links", ->
        loginHelper.loginAsSeller()
        page.get()
        expect(page.productsNavLink().isDisplayed()).toBe(true)
        expect(page.servicesNavLink().isDisplayed()).toBe(true)

      it "shows basic company info and business item sections", ->
        loginHelper.loginAsSeller()
        page.get()
        page.checkSummaryContent()

    describe "when both user", ->
      it "shows products and services nav links", ->
        loginHelper.loginAsBoth()
        page.get()
        expect(page.productsNavLink().isDisplayed()).toBe(true)
        expect(page.servicesNavLink().isDisplayed()).toBe(true)

      it "shows basic company info and business item sections", ->
        loginHelper.loginAsBoth()
        page.get()
        page.checkSummaryContent()

  describe "user is not logged in", ->
    it "redirects to sign in", ->
      page.get()

      helpers.expectUrlChanged("/users/sign_in")
