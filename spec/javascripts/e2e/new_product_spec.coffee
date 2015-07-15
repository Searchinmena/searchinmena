loginHelper = require('./helpers/login_helper.coffee')
helpers = require('./helpers/helpers.coffee')
NewProductPage = require('./helpers/new_product_page.coffee')
ProductsPage = require('./helpers/products_page.coffee')

describe NewProductPage, ->
  page = null
  productsPage = null

  beforeEach ->
    loginHelper.loginAsSeller()
    page = new NewProductPage()
    productsPage = new ProductsPage()

    page.get()

  afterEach ->
    loginHelper.logout()

  it "is possible to add and remove attributes", ->
    page.checkAddingAttributes()

  it "is possible to add and remove photos", ->
    page.checkAddingPhotos()

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

    page.chooseCategory("Sewing Machinery")
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

  it "is possible to choose category, go back and choose different one from the same level", ->
    page.categoryButton().click()

    categories = ["Energy", "Crude Oil"]
    page.chooseCategory(category) for category in categories

    page.breadcrumbs((elements) ->
      expect(elements.length).toEqual(2)
    )
    expect(page.submitCategoryButton().getAttribute("disabled")).toBe(null)

    page.chooseCategory("Petrochemical Products")
    page.breadcrumbs((elements) ->
      expect(elements.length).toEqual(2)
    )

    page.previousCategoryButton().click()
    page.chooseCategory("Petrochemical Products")
    expect(page.breadcrumb("Petrochemical Products").isDisplayed()).toBe(true)
    page.breadcrumbs((elements) ->
      expect(elements.length).toEqual(2)
    )

    page.chooseCategory("Paraffin")
    page.submitCategoryButton().click()

    expect(element(By.css(page.categoriesModalCss)).isElementPresent()).toBe(false)
    expect(page.breadcrumbInForm("Paraffin").isDisplayed()).toBe(true)

  it "is possible to add product", ->
    page.addProduct()

    helpers.expectUrlChanged("/products")

    expect(page.firstBusinessItem().getText()).toEqual("New Product")

    # cleanup
    productsPage.deleteBusinessItem()
