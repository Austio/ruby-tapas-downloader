require_relative './save_file'

class SavePageSource < SaveFile
  private

  def file
    browser.driver.page_source
  end

  def file_name
    'full_page_source.html'
  end
end
