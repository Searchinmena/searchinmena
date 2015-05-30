RegistrationPage = require('./pages/registration_page.coffee')

describe RegistrationPage, ->
  page = null

  beforeEach ->
    page = new RegistrationPage()
    page.get()

  it "doesn't render company info by default", ->
    expect(page.companyInfoElement().isDisplayed()).toBe(false)

  it "shows company info when 'seller' chosen", ->
    page.chooseUserCategory(page.sellerCategory)

    expect(page.companyInfoElement().isDisplayed()).toBe(true)

  it "shows company info when 'both' chosen", ->
    page.chooseUserCategory(page.bothCategory)

    expect(page.companyInfoElement().isDisplayed()).toBe(true)

  it "hides company info when 'buyer' chosen", ->
    page.chooseUserCategory(page.sellerCategory)

    page.chooseUserCategory(page.buyerCategory)

    expect(page.companyInfoElement().isDisplayed()).toBe(false)

  it "persist company option visibility after validation failed", ->
    page.chooseUserCategory(page.sellerCategory)
    page.submitForm()

    expect(page.companyInfoElement().isDisplayed()).toBe(true)

    sellerButton = element(By.id(page.sellerCategory))
    expect(sellerButton.isSelected()).toBe(true)
    
    expect(page.companyNameField().getAttribute("class")).toEqual("field-with-errors")

