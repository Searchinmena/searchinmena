loginHelper = require("./helpers/login_helper.coffee")
CompanyPage = require("./helpers/company_page.coffee")

describe CompanyPage, ->
  page = null

  beforeEach ->
    loginHelper.loginAsBoth()
    page = new CompanyPage()
    page.get()
    page.clearRequiredFields()

  afterEach ->
    loginHelper.logout()

  it "shows errors when inputs are invalid", ->
    page.submitForm()

    expect(page.fieldWithErrors(page.nameFieldLocator).isPresent()).toBe(true)
    expect(page.fieldWithErrors(page.phoneFieldLocator).isPresent()).toBe(true)
    expect(page.fieldWithErrors(page.countrySelectLocator).isPresent())
      .toBe(true)
    expect(page.fieldWithErrors(page.businessTypesSelectLocator).isPresent())
      .toBe(true)

    expect(page.errorFlashMessage().isDisplayed()).toBe(true)

  it "shows no errors when inputs valid", ->
    page.nameField().sendKeys("Lunar Logic")
    page.phoneField().sendKeys("0048 12 430 22 88")

    page.countrySelect().click()
    page.countrySelect().element(By.cssContainingText("option", "Poland"))
      .click()
    browser.actions().mouseDown().mouseUp().perform()

    page.businessTypesSelectToggle().click()
    element(By.linkText("Business services")).click()

    page.submitForm()

    expect(page.fieldsWithErrors().count()).toEqual(0)

  xit "displays success flash message after saving company", ->
    # Right now the check doesn't pass on CircleCI due to the following:
    # https://github.com/wmluke/angular-flash/issues/27,
    # https://github.com/angular/protractor/issues/169
