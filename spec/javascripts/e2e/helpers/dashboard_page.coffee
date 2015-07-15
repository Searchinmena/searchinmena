class DashboardPage
  get: ->
    browser.get("/dashboard")

  productsLink: ->
    element(By.css("a[href='#/products']"))

  servicesLink: ->
    element(By.css("a[href='#/services']"))

module.exports = DashboardPage
