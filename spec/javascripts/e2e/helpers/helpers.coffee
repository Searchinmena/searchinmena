module.exports =
  expectUrlChanged: (path) ->
    browser.getCurrentUrl().then((actualUrl) ->
      path = path.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&")
      expect(new RegExp("#{path}$").test(actualUrl)).toBe(true)
    )

  expectUrlInTargetBlank: (url) ->
    browser.getAllWindowHandles().then((handles) ->
      newWindowHandle = handles[1]
      browser.switchTo().window(newWindowHandle).then(->
        expect(browser.driver.getCurrentUrl()).toBe(url)
      )
    )

  select: (selectElement, optionName) ->
    selectElement.click()
    selectElement.element(By.cssContainingText("option", optionName)).click()
    browser.actions().mouseDown().mouseUp().perform()

