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

  businessTypesSelectToggle: ->
    element(By.id("select-toggle"))

  fieldsWithErrors: ->
    element.all(By.css(".field-with-errors"))

  clearBusinessTypes: ->
    @businessTypesSelectToggle().click()
    element(By.linkText("Uncheck all")).click()
    @businessTypesSelectToggle().click()

  clearCountry: ->
    @countryField().click()
    element(By.cssContainingText("option", "-- Select country --")).click()

  clearRequiredFields: ->
    @nameField().clear()
    @phoneField().clear()
    @clearCountry()
    @clearBusinessTypes()

  submitForm: ->
    submitButton = element(By.css("input[type=submit]"))
    submitButton.click()

  errorFlashMessage: ->
    element(By.cssContainingText("[role=alert]", @errorMessage))

  successFlashMessage: ->
    element(By.cssContainingText("[role=alert]", @successMessage))

module.exports = CompanyPage
