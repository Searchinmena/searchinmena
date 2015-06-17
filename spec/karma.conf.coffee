module.exports = (config) ->
  config.set
    basePath : '../',

    files : [
      'vendor/assets/bower_components/angular/angular.js',
      'vendor/assets/bower_components/angular-mocks/angular-mocks.js',
      'vendor/assets/bower_components/angular-cookies/angular-cookies.js',
      'vendor/assets/bower_components/angular-animate/angular-animate.js',
      'vendor/assets/bower_components/angular-ui-router/release/angular-ui-router.js',
      'vendor/assets/bower_components/ng-tags-input/ng-tags-input.js',
      'vendor/assets/bower_components/angular-flash-alert/dist/angular-flash.js',
      'vendor/assets/bower_components/angular-translate/angular-translate.js',
      'vendor/assets/bower_components/angular-translate-loader-static-files/angular-translate-loader-static-files.js',
      'vendor/assets/bower_components/angular-sanitize/angular-sanitize.js',
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
