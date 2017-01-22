require_relative './save_file'

class SaveVideo < SaveFile
  private

  def data
    open(video_href).read
  end

  def video_href
    links = browser.links
    video_link = links.find{|a| a.html.match video_link_regex}
    video_link.href
  end

  def data_name
    "#{episode_directory}.mp4"
  end

  def video_link_regex
    /.*(download).*(episode)/i
  end
end
