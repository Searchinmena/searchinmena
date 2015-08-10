CompanyShowPage = require("./helpers/company_show_page.coffee")

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