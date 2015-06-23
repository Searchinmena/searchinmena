module.exports = 
  unhide: (element) ->
    # https://code.google.com/p/selenium/wiki/FrequentlyAskedQuestions#Q%3a_Does_WebDriver_support_file_uploads?
    browser.executeScript(
      "arguments[0].style.visibility = 'visible'; arguments[0].style.height = '1px'; arguments[0].style.width = '1px'; arguments[0].style.opacity = 1",
      element.getWebElement())
