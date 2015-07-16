loginHelper = require("./helpers/login_helper.coffee")
CompanyPage = require("./helpers/company_page.coffee")

describe CompanyPage, ->
  page = null

  beforeEach ->
    loginHelper.login()
    page = new CompanyPage()
    page.get()
    page.clearRequiredFields()

  afterEach ->
    loginHelper.logout()

  it "shows errors when inputs are invalid", ->
    page.submitForm()

    expect(element(By.xpath("//div[@error='errors.business.name']")).getAttribute('class')).toMatch(/field-with-errors/)
    expect(element(By.xpath("//div[@error='errors.business.phone']")).getAttribute('class')).toMatch(/field-with-errors/)
    expect(element(By.xpath("//div[@error='errors.business.country_id']")).getAttribute('class')).toMatch(/field-with-errors/)

    # expect(element.all(By.css(".field-with-errors")).count()).toEqual(4)
    expect(page.errorFlashMessage().isDisplayed()).toBe(true)

  it "shows no errors when inputs valid", ->
    page.nameField().sendKeys("Lunar Logic")
    page.phoneField().sendKeys("0048 12 430 22 88")

    page.countryField().click()
    element(By.cssContainingText("option", "Poland")).click()

    page.businessTypesSelectToggle().click()
    element(By.linkText("Business services")).click()

    page.submitForm()

    expect(element(By.xpath("//div[@error='errors.business.name']")).getAttribute('class')).not.toMatch(/field-with-errors/)
    expect(element(By.xpath("//div[@error='errors.business.phone']")).getAttribute('class')).not.toMatch(/field-with-errors/)
    expect(element(By.xpath("//div[@error='errors.business.country_id']")).getAttribute('class')).not.toMatch(/field-with-errors/)

    # expect(page.fieldsWithErrors().count()).toEqual(0)

  xit "displays success flash message after saving company", ->
    # Right now the check doesn't pass on CircleCI due to the following:
    # https://github.com/wmluke/angular-flash/issues/27,
    # https://github.com/angular/protractor/issues/169
