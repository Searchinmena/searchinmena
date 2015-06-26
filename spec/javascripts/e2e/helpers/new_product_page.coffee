path = require('path')
unhideHelper = require('./unhide_helper.coffee')

class NewProductPage
  constructor: ->
    @attributeModel = "attribute.name"
    @addAttributeId = "add-attribute"
    @removeAttributeCss = ".remove-attribute"

    @fileInputCss = "input[type='file']"
    @photoCss = ".photos-preview img"
    @filePath = "../../../support/fixtures/test-image.png"
    @removePhotoCss = ".remove-photo"

    @chooseCategoryId = "choose-category"
    @categoryTitleCss = ".breadcrumbs-title"
    @submitCategoryCss = ".modal-action input"
    @categoryCss = "li.category-name a"
    @breadcrumbCss = ".breadcrumbs-item"
    @previousCategoryId = "previous-category"

  get: ->
    browser.get("/dashboard#/products/new")

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
    element.all(By.css(@breadcrumbCss)).then(callback)

  previousCategoryButton: ->
    element(By.id(@previousCategoryId))

module.exports = NewProductPage
