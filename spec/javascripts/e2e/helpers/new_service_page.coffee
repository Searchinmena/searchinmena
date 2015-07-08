NewBusinessItemPage = require('./new_business_item_page.coffee')

class NewServicePage extends NewBusinessItemPage
  get: ->
    browser.get("/dashboard#/services/new")

module.exports = NewServicePage
