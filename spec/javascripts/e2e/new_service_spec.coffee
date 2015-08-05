loginHelper = require("./helpers/login_helper.coffee")
helpers = require("./helpers/helpers.coffee")
NewServicePage = require("./helpers/new_service_page.coffee")
ServicesPage = require("./helpers/services_page.coffee")

describe NewServicePage, ->
  page = null
  servicesPage = null

  beforeEach ->
    loginHelper.loginAsSeller()
    page = new NewServicePage()
    servicesPage = new ServicesPage()

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

    categories = ["Design Services", "Website Design"]
    for category in categories
      page.chooseCategory(category)
      expect(page.categoryTitle()).toEqual("")
      expect(page.breadcrumb(category).isDisplayed()).toBe(true)

    expect(page.submitCategoryButton().getAttribute("disabled")).toBe(null)

    page.chooseCategory("Website Design")
    page.breadcrumbs((elements) ->
      expect(elements.length).toEqual(2)
    )

    page.chooseCategory("Packaging Design")
    page.breadcrumbs((elements) ->
      expect(elements.length).toEqual(2)
    )

    count = 2
    for category in categories.reverse()
      page.previousCategoryButton().click()
      page.breadcrumbs((elements) ->
        count -= 1
        expect(elements.length).toEqual(count)
      )

    expect(page.categoryTitle()).toEqual("Choose Category")

  it "is possible to choose category, go back and choose different one from the same level", ->
    page.categoryButton().click()

    categories = ["Design Services", "Website Design"]
    page.chooseCategory(category) for category in categories

    page.breadcrumbs((elements) ->
      expect(elements.length).toEqual(2)
    )
    expect(page.submitCategoryButton().getAttribute("disabled")).toBe(null)

    page.chooseCategory("Packaging Design")
    page.breadcrumbs((elements) ->
      expect(elements.length).toEqual(2)
    )

    page.previousCategoryButton().click()
    page.chooseCategory("Packaging Design")
    expect(page.breadcrumb("Packaging Design").isDisplayed()).toBe(true)
    page.breadcrumbs((elements) ->
      expect(elements.length).toEqual(2)
    )

    page.submitCategoryButton().click()

    expect(element(By.css(page.categoriesModalCss)).isElementPresent()).toBe(false)
    expect(page.breadcrumbInForm("Packaging Design").isDisplayed()).toBe(true)

  it "is possible to add service", ->
    page.addService()

    helpers.expectUrlChanged("/#/dashboard/services")

    expect(page.firstBusinessItem().getText()).toEqual("New Service")

    # cleanup
    servicesPage.deleteBusinessItem()

  it "renders errors on failure", ->
    page.checkRenderingErrors()

