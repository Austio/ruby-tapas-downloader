require_relative './save_file'

class SavePageSource < SaveFile
  private

  def data
    browser.driver.page_source
  end

  def data_name
    'full_page_source.html'
  end
end
