loginHelper = require('./helpers/login_helper.coffee')
helpers = require('./helpers/helpers.coffee')
NewProductPage = require('./helpers/new_product_page.coffee')
ProductsPage = require('./helpers/products_page.coffee')

describe ProductsPage, ->
  page = null

  beforeEach ->
    loginHelper.loginAsSeller()
    
    newProductPage = new NewProductPage()
    newProductPage.get()
    newProductPage.addProduct()

    page = new ProductsPage()
    page.get()

  afterEach ->
    loginHelper.logout()

  it "is possible to remove product", ->
    page.deleteBusinessItem()
    expect(page.itemsCount()).toEqual(0)

  it "is possible to see product details", ->
    link = page.showLink()
    href = link.getAttribute("href")
    page.showLink().click()

    expect(browser.getCurrentUrl()).toEqual(href)
