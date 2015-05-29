class RegistrationPage
  constructor: ->
    @companyInfoCss = ".company-info"
    @sellerCategory = "user_category_seller"
    @buyerCategory = "user_category_buyer"

  get: ->
    browser.get("/users/sign_up")

  companyInfoElement: ->
    element(By.css(@companyInfoCss))

  chooseUserCategory: (label) ->
    sellerButton = element(By.id(label))
    sellerButton.click()

module.exports = RegistrationPage
