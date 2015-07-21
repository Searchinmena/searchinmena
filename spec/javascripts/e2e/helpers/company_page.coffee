class CompanyPage
  constructor: ->
    @errorMessage = "Company couldn't be saved, please check the form"
    @successMessage = "Company information was successfully saved"
    @nameFieldLocator = By.model("form.business.name")
    @phoneFieldLocator = By.model("form.business.phone")
    @countrySelectLocator = By.model("form.business.country_id")
    @businessTypesSelectLocator = By.id("select-toggle")

  get: ->
    browser.get("/dashboard#/company")

  nameField: ->
    element(@nameFieldLocator)

  phoneField: ->
    element(@phoneFieldLocator)

  countrySelect: ->
    element(@countrySelectLocator)

  businessTypesSelectToggle: ->
    element(@businessTypesSelectLocator)

  select: (selectElement, optionName) ->
      selectElement.click()
      selectElement.element(By.cssContainingText("option", optionName)).click()
      browser.actions().mouseDown().mouseUp().perform()

  fieldsWithErrors: ->
    element.all(By.css(".field-with-errors"))

  fieldWithErrors: (locator) ->
    element.all(By.css(".field-with-errors")).all(locator).first()

  clearBusinessTypes: ->
    @businessTypesSelectToggle().click()
    element(By.linkText("Uncheck all")).click()
    @businessTypesSelectToggle().click()

  clearCountry: ->
    @select(@countrySelect(), "Select country")

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
