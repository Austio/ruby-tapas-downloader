require_relative './save_file'

class SaveVideo < SaveFile
  private

  def file
    links = browser.links
    video_link = links.find{|a| a.html.match video_link_regex}
    video_href = video_link.href

    open(video_href).read
  end

  def file_name
    "#{episode_directory}.mp4"
  end

  def video_link_regex
    /.*(download).*(episode)/i
  end
end
