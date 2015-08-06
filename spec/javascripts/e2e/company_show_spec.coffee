CompanyShowPage = require("./helpers/company_show_page.coffee")

describe CompanyShowPage, ->
  page = null

  beforeEach ->
    page = new CompanyShowPage()
    page.get()

  it "displays basic informations", ->
    # business name
    expect(element(By.cssContainingText('h2', 'Business1')).isDisplayed()).toBeTruthy();
    # phone number
    expect(element(By.cssContainingText('div', '777-777-777')).isDisplayed()).toBeTruthy();
    # city and country name
    expect(element(By.cssContainingText('div', 'Krakow, Value1')).isDisplayed()).toBeTruthy();
    # business types
    expect(element(By.cssContainingText('td', 'Value2')).isDisplayed()).toBeTruthy();
    # tags
    expect(element(By.cssContainingText('td', 'Value3')).isDisplayed()).toBeTruthy();
    # year registered
    expect(element(By.cssContainingText('td', '2011')).isDisplayed()).toBeTruthy();
    # no of employees
    expect(element(By.cssContainingText('td', '123')).isDisplayed()).toBeTruthy();
    # introduction
    expect(element(By.cssContainingText('p', 'business introduction')).isDisplayed()).toBeTruthy();