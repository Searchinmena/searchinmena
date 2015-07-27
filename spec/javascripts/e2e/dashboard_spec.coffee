loginHelper = require('./helpers/login_helper.coffee')
helpers = require('./helpers/helpers.coffee')
DashboardPage = require('./helpers/dashboard_page.coffee')

describe DashboardPage, ->
  page = null

  beforeEach ->
    page = new DashboardPage()

  describe 'user is logged in', ->
    afterEach ->
      loginHelper.logout()

    describe 'buyer user', ->
      it 'hides products and services', ->
        loginHelper.loginAsBuyer()
        page.get()
        expect(page.productsLink().isDisplayed()).toBe(false)
        expect(page.servicesLink().isDisplayed()).toBe(false)

    describe 'seller user', ->
      it 'shows products and services', ->
        loginHelper.loginAsSeller()
        page.get()
        expect(page.productsLink().isDisplayed()).toBe(true)
        expect(page.servicesLink().isDisplayed()).toBe(true)

    describe 'both user', ->
      it 'shows products and services', ->
        loginHelper.loginAsBoth()
        page.get()
        expect(page.productsLink().isDisplayed()).toBe(true)
        expect(page.servicesLink().isDisplayed()).toBe(true)

  describe 'user is not logged in', ->
    it 'redirects to sign in', ->
      page.get()

      helpers.expectUrlChanged('/users/sign_in')

