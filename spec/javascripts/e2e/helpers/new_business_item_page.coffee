path = require('path')
unhideHelper = require('./unhide_helper.coffee')

class NewBusinessItemPage
  constructor: ->
    @attributeModel = "attribute.name"
    @addAttributeId = "add-attribute"
    @removeAttributeCss = ".remove-attribute"

    @fileInputCss = "input[type='file']"
    @photoCss = ".photos-preview img"
    @filePath = "../../../support/fixtures/test-image.png"
    @removePhotoCss = ".remove-photo"

    @categoriesModalCss = ".categories-modal"
    @chooseCategoryId = "choose-category"
    @categoryTitleCss = ".breadcrumbs-title"
    @submitCategoryCss = ".modal-action input"
    @categoryCss = "a.category-name"
    @breadcrumbCss = "#modal-breadcrumbs .breadcrumbs-item"
    @previousCategoryId = "previous-category"

    @breadcrumbInFormCss = "#category .breadcrumbs-item"

    @submitCss = ".actions input"

    @itemTitleCss = ".item-title"

  attributes: ->
    element.all(By.model(@attributeModel))

  addAttributeButton: ->
    element(By.id(@addAttributeId))

  removeAttributeButton: ->
    element.all(By.css(@removeAttributeCss)).get(0)

  photos: ->
    element.all(By.css(@photoCss))

  uploadFile: ->
    absolutePath = path.resolve(__dirname, @filePath)
    fileElement = element(By.css(@fileInputCss))

    # Need to unhide flowjs's secret file uploader
    unhideHelper.unhide(fileElement)

    fileElement.sendKeys(absolutePath)

  removePhotoButton: ->
    element.all(By.css(@removePhotoCss)).get(0)

  categoryButton: ->
    element(By.id(@chooseCategoryId))

  categoryTitle: ->
    element(By.css(@categoryTitleCss)).getText()

  submitCategoryButton: ->
    element(By.css(@submitCategoryCss))

  chooseCategory: (category) ->
    element(By.cssContainingText(@categoryCss, category)).click()

  breadcrumb: (category) ->
    element(By.cssContainingText(@breadcrumbCss, category))

  breadcrumbs: (callback) ->
    element.all(By.css(@breadcrumbCss)).filter((elem) ->
      elem.isDisplayed().then((isDisplayed) ->
        isDisplayed == true
      )
    ).then(callback)

  previousCategoryButton: ->
    element(By.id(@previousCategoryId))

  breadcrumbInForm: (category) ->
    element(By.cssContainingText(@breadcrumbInFormCss, category))
  
  nameInput: ->
    element(By.model("form.business_item.name"))

  modelNumberInput: ->
    element(By.model("form.business_item.model_number"))

  minOrderInput: ->
    element(By.model("form.business_item.min_order_quantity_number"))

  fobPriceInput: ->
    element(By.model("form.business_item.fob_price"))

  supplyAbilityInput: ->
    element(By.model("form.business_item.supply_ability_capacity"))

  submitForm: ->
    submitButton = element(By.css(@submitCss))
    submitButton.click()

  checkAddingAttributes: ->
    expect(@attributes().count()).toBe(1)

    @addAttributeButton().click()
    expect(@attributes().count()).toBe(2)

    @removeAttributeButton().click()
    expect(@attributes().count()).toBe(1)

  checkAddingPhotos: ->
    expect(@photos().count()).toBe(0)

    @uploadFile()
    expect(@photos().count()).toBe(1)

    @removePhotoButton().click()
    expect(@photos().count()).toBe(0)

  firstBusinessItem: ->
    element.all(By.css(@itemTitleCss)).get(0)

module.exports = NewBusinessItemPage

