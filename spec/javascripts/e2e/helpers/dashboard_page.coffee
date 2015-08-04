class DashboardPage
  get: ->
    browser.get("/#/dashboard")

  productsNavLink: ->
    element(By.css(".dashboard-navigation [href='#/dashboard/products']"))

  servicesNavLink: ->
    element(By.css(".dashboard-navigation [href='#/dashboard/services']"))

  companyName: ->
    element(By.css(".dashboard-content .company-name"))

  editCompanyLink: ->
    element(By.css(".dashboard-content [href='#/dashboard/company/basic_info']"))

  productsLink: ->
    element(By.css(".dashboard-content [href='#/dashboard/products']"))

  servicesLink: ->
    element(By.css(".dashboard-content [href='#/dashboard/services']"))

  addNewProductLink: ->
    element(By.css(".dashboard-content [href='#/dashboard/products/new']"))

  addNewServiceLink: ->
    element(By.css(".dashboard-content [href='#/dashboard/services/new']"))

  emptyProducts: ->
    element(By.cssContainingText(".empty-index", "No products yet."))

  emptyServices: ->
    element(By.cssContainingText(".empty-index", "No services yet."))

  buyerContent: ->
    element(By.css(".buyer-dashboard-content"))

  browseLink: ->
    element(By.css("[href='#/browse']"))

  createCompanyLink: ->
    element(By.css(".buyer-dashboard-content [href='#/dashboard/company/basic_info']"))

module.exports = DashboardPage
