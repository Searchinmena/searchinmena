class CompanyPage
  constructor: ->
    @errorMessage = "Company couldn't be saved, please check the form"
    @successMessage = "Company information was successfully saved"

  get: ->
    browser.get("/dashboard#/company")

  nameField: ->
    element(By.model("form.business.name"))

  phoneField: ->
    element(By.model("form.business.phone"))

  countryField: ->
    element(By.model("form.business.country_id"))

  businessTypesSelectField: ->
    element(By.id("select-toggle"))

  submitForm: ->
    submitButton = element(By.css("input[type=submit]"))
    submitButton.click()

  errorFlashMessage: ->
    element(By.cssContainingText("[role=alert]", @errorMessage))

  successFlashMessage: ->
    element(By.cssContainingText("[role=alert]", @successMessage))

module.exports = CompanyPage
