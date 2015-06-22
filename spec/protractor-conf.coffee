exports.config =
  capabilities: {
    'browserName': 'firefox'
  },
  specs: ['javascripts/e2e/*.coffee'],
  baseUrl: 'http://localhost:3000/',
  onPrepare: () ->
    browser.driver.manage().window().maximize()
