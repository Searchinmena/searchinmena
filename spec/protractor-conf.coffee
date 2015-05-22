exports.config =
  capabilities: {
    'browserName': 'phantomjs',
    'phantomjs.binary.path': require('phantomjs').path,
  }
  specs: ['javascripts/e2e/*.coffee'],
  baseUrl: 'http://localhost:3000/'

