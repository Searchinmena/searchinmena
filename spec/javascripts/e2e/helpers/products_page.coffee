BusinessItemsPage = require('./business_items_page.coffee')

class ProductsPage extends BusinessItemsPage
  get: ->
    browser.get("/#/dashboard/products")

module.exports = ProductsPage
