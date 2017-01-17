require_relative '../pages/login_page'

class LoggedBrowser
  def call
    LoginPage.new(browser).login

    browser
  end

  def browser
    @browser ||= MY_BROWSER.empty? ? Watir::Browser.new : Watir::Browser.new(MY_BROWSER)
  end

end
