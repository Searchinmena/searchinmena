NewBusinessItemPage = require('./new_business_item_page.coffee')

class NewProductPage extends NewBusinessItemPage
  get: ->
    browser.get("/dashboard#/products/new")

module.exports = NewProductPage
