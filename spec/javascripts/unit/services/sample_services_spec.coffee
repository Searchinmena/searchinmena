describe "sampleService", ->
  _sampleService = null

  beforeEach ->
    angular.mock.module('sim')
    inject (sampleService) ->
      _sampleService = sampleService

  describe "randomNumber", ->
    it "returns 4", ->
      expect(_sampleService.randomNumber()).toEqual(4)
