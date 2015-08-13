CompanyShowPage = require("./helpers/company_show_page.coffee")
helpers = require('./helpers/helpers.coffee')
loginHelper = require('./helpers/login_helper.coffee')

describe CompanyShowPage, ->
  page = null

  beforeEach ->
    page = new CompanyShowPage()
    page.get()

  xit "displays basic informations", ->
    expect(page.isBusinessNameDisplayed()).toBeTruthy()
    expect(page.isPhoneDisplayed()).toBeTruthy()
    expect(page.isCityAndCountryNameDisplayed()).toBeTruthy()
    expect(page.areBusinessTypesDisplayed()).toBeTruthy()
    expect(page.areTagsDisplayed()).toBeTruthy()
    expect(page.isNoOfEmployeesDisplayed()).toBeTruthy()
    expect(page.isIntroductionDisplayed()).toBeTruthy()

  it "open contact sender modal", ->
    page.contactSupplierButton().click()
    helpers.expectUrlChanged("/users/sign_in")

    loginHelper.loginAsBuyer()
    page.get()
    page.contactSupplierButton().click()
    expect(page.messageModal().isPresent()).toBe(true)

