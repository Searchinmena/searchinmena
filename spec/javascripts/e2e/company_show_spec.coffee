CompanyShowPage = require("./helpers/company_show_page.coffee")
helpers = require('./helpers/helpers.coffee')
loginHelper = require('./helpers/login_helper.coffee')

describe CompanyShowPage, ->
  page = null

  beforeEach ->
    page = new CompanyShowPage()

  xit "displays basic information", ->
    page.get()
    expect(page.isBusinessNameDisplayed()).toBeTruthy()
    expect(page.isPhoneDisplayed()).toBeTruthy()
    expect(page.isCityAndCountryNameDisplayed()).toBeTruthy()
    expect(page.areBusinessTypesDisplayed()).toBeTruthy()
    expect(page.areTagsDisplayed()).toBeTruthy()
    expect(page.isNoOfEmployeesDisplayed()).toBeTruthy()
    expect(page.isIntroductionDisplayed()).toBeTruthy()

  describe "contact button", ->
    describe "when user not logged in", ->
      it "redirects to sign in page", ->
        page.get()
        page.contactSupplierButton().click()
        helpers.expectUrlChanged("/users/sign_in")

    describe "when user logged in", ->
      it "opens contact sender modal", ->
        loginHelper.loginAsBuyer()
        page.get()
        page.contactSupplierButton().click()
        expect(page.messageModal().isPresent()).toBe(true)
