class RegistrationPage
  constructor: ->
    @companyInfoCss = ".company-info"
    @sellerCategory = "user_category_seller"
    @buyerCategory = "user_category_buyer"
    @bothCategory = "user_category_both"
    @companyNameCss = "user_business_name"

  get: ->
    browser.get("/users/sign_up")

  companyInfoElement: ->
    element(By.css(@companyInfoCss))

  companyNameField: ->
    companyNameInput = element(By.id(@companyNameCss))
    companyNameInput.element(By.xpath(".."))

  chooseUserCategory: (label) ->
    radioButton = element(By.id(label))
    radioButton.click()

  tagInput: ->
    element(By.model("form.tags")).element(By.css("input[type=text]"))

  submitForm: ->
    submitButton = element(By.css("input[type=submit]"))
    submitButton.click()

module.exports = RegistrationPage
