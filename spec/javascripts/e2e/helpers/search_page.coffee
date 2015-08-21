class SearchPage
  get: ->
    browser.get("/#/home")

  searchTypeSelect: ->
    element(By.model('search.type'))

  searchQueryInput: ->
    element(By.model('search.query'))

  submitButton: ->
    element(By.css("input[type='submit']"))

  resultItem: (name) ->
    element(By.cssContainingText('a.result-item-title', name))

module.exports = SearchPage
