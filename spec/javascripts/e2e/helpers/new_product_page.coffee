NewBusinessItemPage = require("./new_business_item_page.coffee")

class NewProductPage extends NewBusinessItemPage
  get: ->
    browser.get("/#/dashboard/products/new")

  addProduct: ->
    categories = ["Energy", "Crude Oil"]
    @addBusinessItem("New Product", categories)

module.exports = NewProductPage
