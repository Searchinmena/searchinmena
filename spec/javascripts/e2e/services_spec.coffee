loginHelper = require('./helpers/login_helper.coffee')
NewServicePage = require('./helpers/new_service_page.coffee')
ServicesPage = require('./helpers/services_page.coffee')

describe ServicesPage, ->
  page = null

  beforeEach ->
    loginHelper.loginAsSeller()
    
    newServicePage = new NewServicePage()
    newServicePage.get()
    newServicePage.addService()

    page = new ServicesPage()
    page.get()

  afterEach ->
    loginHelper.logout()

  it "is possible to remove service", ->
    page.deleteBusinessItem()
    expect(page.itemsCount()).toEqual(0)
