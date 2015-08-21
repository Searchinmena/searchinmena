loginHelper = require("./helpers/login_helper.coffee")
helpers = require("./helpers/helpers.coffee")
NewProductPage = require('./helpers/new_product_page.coffee')
ProductsPage = require("./helpers/products_page.coffee")
SearchPage = require("./helpers/search_page.coffee")

describe SearchPage, ->
  page = null
  productsPage = null

  beforeEach ->
    loginHelper.loginAsSeller()

    newProductPage = new NewProductPage()
    newProductPage.get()
    newProductPage.addProduct()
    productsPage = new ProductsPage()

    page = new SearchPage()
    page.get()

  describe "user is logged in", ->
    afterEach ->
      loginHelper.logout()

    it "shows results", ->
      helpers.select(page.searchTypeSelect(), "Product")
      page.searchQueryInput().sendKeys("New Product")
      page.submitButton().click()

      expect(page.resultItem("New Product").isDisplayed()).toBe(true)

      # cleanup
      productsPage.get()
      productsPage.deleteBusinessItem()
