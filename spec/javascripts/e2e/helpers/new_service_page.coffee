NewBusinessItemPage = require('./new_business_item_page.coffee')

class NewServicePage extends NewBusinessItemPage
  get: ->
    browser.get("/#/dashboard/services/new")

  addService: ->
    categories = ["Design Services", "Website Design"]
    @addBusinessItem("New Service", categories)

module.exports = NewServicePage
