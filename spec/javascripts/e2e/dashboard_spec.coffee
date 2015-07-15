loginHelper = require('./helpers/login_helper.coffee')
DashboardPage = require('./helpers/dashboard_page.coffee')

describe DashboardPage, ->
  page = null

  beforeEach ->
    page = new DashboardPage()

  afterEach ->
    loginHelper.logout()

  describe "buyer user", ->
    it "hides products and services", ->
      loginHelper.loginAsBuyer()
      page.get()
      expect(page.productsLink().isPresent()).toBe(false)
      expect(page.servicesLink().isPresent()).toBe(false)

  describe "seller user", ->
    it "shows products and services", ->
      loginHelper.loginAsSeller()
      page.get()
      expect(page.productsLink().isPresent()).toBe(true)
      expect(page.servicesLink().isPresent()).toBe(true)

  describe "both user", ->
    it "shows products and services", ->
      loginHelper.loginAsBoth()
      page.get()
      expect(page.productsLink().isPresent()).toBe(true)
      expect(page.servicesLink().isPresent()).toBe(true)
