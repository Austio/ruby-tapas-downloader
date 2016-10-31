require_relative './save_file'

class SaveContentHtml < SaveFile
  private

  def file
    div = browser.div class: 'entry-content'
    div.html
  end

  def file_name
    'page_content.html'
  end
end
