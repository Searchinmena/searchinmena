describe 'DashboardCtrl', ->
  xit 'should have proper greeting', ->
    browser.get('/#/dashboard')
    greeting = element(By.binding('test'))

    expect(greeting.getText()).toEqual('Hello world! 4')

