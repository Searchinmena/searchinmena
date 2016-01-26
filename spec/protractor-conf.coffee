exports.config =
  capabilities: {
    'browserName': 'chrome'
  },
  specs: ['javascripts/e2e/*.coffee'],
  baseUrl: 'http://localhost:3000/',
  onPrepare: () ->
    browser.driver.manage().window().maximize()
    browser.get('/')
