class RegistrationPage
  constructor: ->
    @businessInfoCss = ".business-info"
    @sellerCategory = "user_category_seller"
    @buyerCategory = "user_category_buyer"
    @bothCategory = "user_category_both"
    @businessNameCss = "user_business_name"

  get: ->
    browser.get("/users/sign_up")

  businessInfoElement: ->
    element(By.css(@businessInfoCss))

  businessNameField: ->
    businessNameInput = element(By.id(@businessNameCss))
    businessNameInput.element(By.xpath(".."))

  chooseUserCategory: (label) ->
    radioButton = element(By.id(label))
    radioButton.click()

  tagInput: ->
    element(By.model("form.tags")).element(By.css("input[type=text]"))

  selectBusinessTypesInput: ->
    element(By.id("select-toggle"))

  submitForm: ->
    submitButton = element(By.css("input[type=submit]"))
    submitButton.click()

module.exports = RegistrationPage
