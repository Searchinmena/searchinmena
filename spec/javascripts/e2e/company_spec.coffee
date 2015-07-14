loginHelper = require("./helpers/login_helper.coffee")
CompanyPage = require("./helpers/company_page.coffee")

describe CompanyPage, ->
  page = null

  beforeEach ->
    loginHelper.login()
    page = new CompanyPage()
    page.get()

  afterEach ->
    loginHelper.logout()

  it "shows error when inputs are invalid", ->
    page.nameField().clear()
    page.submitForm()

    page.errors((elements) ->
      expect(elements.length).toBeGreaterThan(0)
    )

    expect(page.errorFlashMessage().isDisplayed()).toBe(true)

  it "is possible to add company", ->
    page.nameField().clear().sendKeys("Lunar Logic")
    page.phoneField().clear().sendKeys("0048 12 430 22 88")
    page.countryField().click()
    element(By.cssContainingText("option", "Poland")).click()
    page.businessTypesSelectField().click()
    element(By.linkText("Uncheck all")).click()
    element(By.linkText("Business services")).click()
    page.submitForm()

    page.errors((elements) ->
      expect(elements.length).toBe(0)
    )

  xit "displays success flash message after saving company", ->
    # Right now the check doesn't pass on CircleCI due to the following:
    # https://github.com/wmluke/angular-flash/issues/27,
    # https://github.com/angular/protractor/issues/169
