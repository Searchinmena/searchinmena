RegistrationPage = require("./helpers/registration_page.coffee")

describe RegistrationPage, ->
  page = null

  beforeEach ->
    page = new RegistrationPage()
    page.get()

  it "doesn't render business info by default", ->
    expect(page.businessInfoElement().isDisplayed()).toBe(false)

  it "shows business info when 'seller' chosen", ->
    page.chooseUserCategory(page.sellerCategory)

    expect(page.businessInfoElement().isDisplayed()).toBe(true)

  it "shows business info when 'both' chosen", ->
    page.chooseUserCategory(page.bothCategory)

    expect(page.businessInfoElement().isDisplayed()).toBe(true)

  it "hides business info when 'buyer' chosen", ->
    page.chooseUserCategory(page.sellerCategory)

    page.chooseUserCategory(page.buyerCategory)

    expect(page.businessInfoElement().isDisplayed()).toBe(false)

  it "persist business option visibility after validation failed", ->
    page.chooseUserCategory(page.sellerCategory)
    page.submitForm()

    expect(page.businessInfoElement().isDisplayed()).toBe(true)

    sellerButton = element(By.id(page.sellerCategory))
    expect(sellerButton.isSelected()).toBe(true)

    businessNameField = page.businessNameField()
    expect(businessNameField.element(By.className("error"))
      .isDisplayed()).toBe(true)
    expect(businessNameField.getAttribute("class"))
      .toContain("field-with-errors")

  it "is possible to add tag", ->
    page.chooseUserCategory(page.sellerCategory)

    page.tagInput().sendKeys("Ania", protractor.Key.RETURN)
    expect(element(By.cssContainingText("span", "Ania")).isDisplayed()).toBe(true)

  it "is possible to add business types", ->
    page.chooseUserCategory(page.sellerCategory)

    selectButton = page.selectBusinessTypesInput()
    selectButton.click()

    element(By.linkText("Manufacturer")).click()
    element(By.linkText("Agent")).click()

    expect(selectButton.getText()).toEqual("Manufacturer, Agent")
