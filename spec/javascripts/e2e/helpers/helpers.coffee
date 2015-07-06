module.exports =
  expectUrlChanged: (path) ->
    browser.getCurrentUrl().then((actualUrl) ->
      path = path.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&")
      expect(new RegExp("#{path}$").test(actualUrl)).toBe(true)
    )
