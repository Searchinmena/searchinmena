class DashboardPage
  get: ->
    browser.get("/#/dashboard")

  productsLink: ->
    element(By.css("a[href='#/dashboard/products']"))

  servicesLink: ->
    element(By.css("a[href='#/dashboard/services']"))

module.exports = DashboardPage
