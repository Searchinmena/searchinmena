BusinessItemsPage = require('./business_items_page.coffee')

class ServicesPage extends BusinessItemsPage
  get: ->
    browser.get("/#/dashboard/services")

module.exports = ServicesPage
