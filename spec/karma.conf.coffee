module.exports = (config) ->
  config.set
    basePath : '../',

    files : [
      'vendor/assets/bower_components/angular/angular.js',
      'vendor/assets/bower_components/angular-mocks/angular-mocks.js',
      'vendor/assets/bower_components/angular-ui-router/release/angular-ui-router.js',
      'app/assets/javascripts/sim.coffee',
      'app/assets/javascripts/**/*.coffee',
      'spec/javascripts/unit/**/*.coffee'
    ],

    autoWatch : true,

    frameworks: ['jasmine'],

    browsers: ['PhantomJS'],

    plugins : [
            'karma-coffee-preprocessor',
            'karma-phantomjs-launcher',
            'karma-jasmine'
            ],

    junitReporter : {
      outputFile: 'test_out/unit.xml',
      suite: 'unit'
    },

    preprocessors: {
      "**/*.coffee": ["coffee"]
    }

