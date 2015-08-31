helper = require("./helpers/locale_helper.coffee")
loginHelper = require("./helpers/login_helper.coffee")

describe "Locale switching", ->
  it "it switches language and dir", ->
    browser.get("/users/sign_in")

    helper.switchLanguage("العربية")

    expect(helper.signInHeader().getText()).toEqual("تسجيل الدخول")

    expect(helper.dirAttribute()).toEqual("rtl")

    loginHelper.loginAsSeller()

    expect(helper.activeLink().getText()).toEqual("الصفحة الرئيسية")

    helper.goToOtherDashboardPart()

    expect(helper.dirAttribute()).toEqual("rtl")

    helper.switchLanguage("English")

    expect(helper.dirAttribute()).not.toEqual("rtl")

    loginHelper.logout()
