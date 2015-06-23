loginHelper = require('./helpers/login_helper.coffee')
NewProductPage = require('./helpers/new_product_page.coffee')

describe NewProductPage, ->
  page = null

  beforeEach ->
    loginHelper.login()
    page = new NewProductPage()
    page.get()

  afterEach ->
    loginHelper.logout()

  it "is possible to add and remove attributes", ->
    expect(page.attributes().count()).toBe(1)

    page.addAttributeButton().click()
    expect(page.attributes().count()).toBe(2)

    page.removeAttributeButton().click()
    expect(page.attributes().count()).toBe(1)

  it "is possible to add and remove photos", ->
    expect(page.photos().count()).toBe(0)

    page.uploadFile()
    expect(page.photos().count()).toBe(1)

    page.removePhotoButton().click()
    expect(page.photos().count()).toBe(0)
