describe 'DashboardCtrl', ->
  it 'should have a title', ->
    browser.get('/#/dashboard')
    greeting = element(By.binding('test'))

    expect(greeting.getText()).toEqual('Hello world! 4')

