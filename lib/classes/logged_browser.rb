require_relative '../pages/login_page'

class LoggedBrowser
  def call
    LoginPage.new(browser).login

    browser
  end

  def browser
    @browser ||= Watir::Browser.new
  end
end
