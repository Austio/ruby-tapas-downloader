require_relative './save_file'

class SaveContentHtml < SaveFile
  private

  def data
    div = browser.div class: 'entry-content'
    div.html
  end

  def data_name
    'page_content.html'
  end
end
