module.exports = (config) ->
  config.set
    basePath : '../',

    files : [
      'https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js'
      'vendor/assets/bower_components/angular/angular.js',
      'vendor/assets/bower_components/angular-mocks/angular-mocks.js',
      'vendor/assets/bower_components/angular-ui-router/release/angular-ui-router.js',
      'vendor/assets/bower_components/ng-tags-input/ng-tags-input.js',
      'app/assets/javascripts/sim.coffee',
      'app/assets/javascripts/**/*.coffee',
      'spec/javascripts/unit/**/*.coffee'
    ],

    autoWatch : true,

    frameworks: ['jasmine'],

    browsers: ['Firefox'],

    plugins : [
            'karma-coffee-preprocessor',
            'karma-firefox-launcher',
            'karma-jasmine'
            ],

    junitReporter : {
      outputFile: 'test_out/unit.xml',
      suite: 'unit'
    },

    preprocessors: {
      "**/*.coffee": ["coffee"]
    }

