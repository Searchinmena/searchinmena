class CompanyShowPage
  get: ->
    browser.get("/#/company/1")

  isBusinessNameDisplayed: ->
    element(By.cssContainingText('h2', 'Business1')).isDisplayed()

  isPhoneDisplayed: ->
    element(By.cssContainingText('div', '777-777-777')).isDisplayed()

  isCityAndCountryNameDisplayed: ->
    element(By.cssContainingText('div', 'Krakow, Value1')).isDisplayed()

  areBusinessTypesDisplayed: ->
    element(By.cssContainingText('td', 'Value2')).isDisplayed()

  areTagsDisplayed: ->
    element(By.cssContainingText('td', 'Value3')).isDisplayed()

  isYearRegisteredDisplayed: ->
    element(By.cssContainingText('td', '2011')).isDisplayed()

  isNoOfEmployeesDisplayed: ->
    element(By.cssContainingText('td', '123')).isDisplayed()

  isIntroductionDisplayed: ->
    element(By.cssContainingText('p', 'business introduction')).isDisplayed()

module.exports = CompanyShowPage
