class LoginPage < Struct.new(:browser)
  def login
    browser.goto login_url

    fill_in_username
    fill_in_password
    click_submit

    browser
  end

  private

  def fill_in_username
    t = browser.text_field id: username_input_id
    t.set USER_NAME
  end

  def fill_in_password
    t = browser.text_field id: password_input_id
    t.set USER_PASSWORD
  end

  def click_submit
    btn = browser.button id: 'wp-submit'
    btn.click
  end

  def login_url
    'rubytapas.com/login'
  end

  def username_input_id
    'user_login'
  end

  def password_input_id
    'user_pass'
  end
end