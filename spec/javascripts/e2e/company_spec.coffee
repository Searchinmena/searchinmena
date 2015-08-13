loginHelper = require("./helpers/login_helper.coffee")
CompanyPage = require("./helpers/company_page.coffee")

describe CompanyPage, ->
  page = null

  beforeEach ->
    loginHelper.loginAsBoth()
    page = new CompanyPage()
    page.get()
    page.clearRequiredFields()
    page.clearTags()

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
    page.fillRequiredFields()

    page.submitForm()

    expect(page.fieldsWithErrors().count()).toEqual(0)

  it "adds and removes tags", ->
    page.fillRequiredFields()

    # new tags
    page.tagInput().sendKeys("Ania", protractor.Key.RETURN)
    page.tagInput().sendKeys("Hania", protractor.Key.RETURN)

    # autocomplete
    page.tagInput().sendKeys("Comb")
    page.clickSuggestedTag()

    page.submitForm()
    # page.get()
    expect(page.fieldsWithErrors().count()).toEqual(0)

    # tags should be added
    expect(element(By.cssContainingText("span", "Ania")).isDisplayed()).toBe(true)
    expect(element(By.cssContainingText("span", "Hania")).isDisplayed()).toBe(true)
    expect(element(By.cssContainingText("span", "Comb")).isDisplayed()).toBe(true)

    page.removeTagButton("Ania")
    page.submitForm()
    # page.get()
    expect(page.fieldsWithErrors().count()).toEqual(0)

    # tag should be removed
    expect(element(By.cssContainingText("span", "Ania")).isPresent()).toBe(false)

    # this tag should be still present
    expect(element(By.cssContainingText("span", "Hania")).isDisplayed()).toBe(true)

  xit "displays success flash message after saving company", ->
    # Right now the check doesn't pass on CircleCI due to the following:
    # https://github.com/wmluke/angular-flash/issues/27,
    # https://github.com/angular/protractor/issues/169


