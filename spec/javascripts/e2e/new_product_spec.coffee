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

  it "is possible to choose category", ->
    page.categoryButton().click()

    expect(page.categoryTitle()).toEqual("Choose Category")
    expect(page.submitCategoryButton().getAttribute("disabled")).toEqual("true")

    categories = [
      "Machinery",
      "Apparel & Textile Machinery",
      "Apparel Machinery",
      "Zipper Making Machinery"
    ]
    for category in categories
      page.chooseCategory(category)
      expect(page.categoryTitle()).toEqual("")
      expect(page.breadcrumb(category).isDisplayed()).toBe(true)

    expect(page.submitCategoryButton().getAttribute("disabled")).toBe(null)

    page.chooseCategory("Zipper Making Machinery")
    page.breadcrumbs((elements) ->
      expect(elements.length).toEqual(4)
    )

    count = 4
    for category in categories.reverse()
      page.previousCategoryButton().click()
      page.breadcrumbs((elements) ->
        count -= 1
        expect(elements.length).toEqual(count)
      )

    expect(page.categoryTitle()).toEqual("Choose Category")

