loginHelper = require('./helpers/login_helper.coffee')
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
    page.checkRemovingBusinessItem()

  it "is possible to see product details", ->
    page.checkShowingSingleBusinessItem()
