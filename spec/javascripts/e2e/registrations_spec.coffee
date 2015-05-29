RegistrationPage = require('./pages/registration_page.coffee')

describe RegistrationPage, ->
  page = null

  beforeEach ->
    page = new RegistrationPage()
    page.get()

  it "doesn't render company info by default", ->
    expect(page.companyInfoElement().isDisplayed()).toBe(false)

  it "shows company info when 'seller' chosen", ->
    page.chooseUserCategory("user_category_seller")

    expect(page.companyInfoElement().isDisplayed()).toBe(true)

  it "hides company info when 'buyer' chosen", ->
    page.chooseUserCategory(page.sellerCategory)

    page.chooseUserCategory(page.buyerCategory)

    expect(page.companyInfoElement().isDisplayed()).toBe(false)

